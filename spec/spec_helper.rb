require 'everscale-client-ruby' # and any other gems you need

include CommonInstanceHelpers

RSpec.configure do |config|
  config.full_backtrace = true
  # some (optional) config here
end

def project_root
  if defined?(Rails)
    return Rails.root.to_s
  end

  if defined?(Bundler)
    return Bundler.root.to_s
  end

  Dir.pwd.to_s
end

def env
  Dotenv.parse('.env.test').merge(ENV)
end

def make_client
  TonClient.configure { |config| config.ffi_lib(env['spec_ffi']) }
  TonClient.create(config: {network: {server_address: env['server_address'] || "net.ton.dev"}})
end

# def requestLibrarySync(context: 1, method_name: '', payload: {})
#   responses = []
#   queue = Queue.new
#   TonClient::TonBinding.requestLibrary(context: context, method_name: method_name, payload: payload) do |response|
#     responses << response
#     queue.push 1 if response.finished == true
#   end
#   queue.pop
#   yield(responses) if block_given?
# end

def callLibraryMethodSync(method, *args)
  responses = Concurrent::Array.new
  queue = Queue.new
  method.call(*args) do |response|
    responses << response
    queue.push 1 if response.finished == true
  end
  queue.pop
  yield(responses.map{ |resp| resp if resp.result }.compact) if block_given?
end

def read_abi(name)
  file = File.read(project_root + "/spec/Fixtures/abi/#{name}.abi.json")
  JSON.parse(file)
end

def read_tvc(name)
  data = File.open(project_root + "/spec/Fixtures/abi/#{name}.tvc").read
  # Encode the puppy
  encoded = Base64.encode64(data)
  # Spit it out into one continous string
  encoded.gsub(/\n/, '')
end

def generate_keys
  client = make_client
  callLibraryMethodSync(client.crypto.method(:generate_random_sign_keys)) do |response|
    return response.first.result
  end
end

def abiEncodeMessage(name_abi: '', name_tvc: nil, address: nil, public_key: nil, secret_key: nil, call_set_function_name: nil, call_set_header: nil, call_set_input: nil)
  abi = {type: 'Serialized', value: read_abi(name_abi)}
  
  deploy_set = nil
  if name_tvc
    deploy_set = {tvc: read_tvc(name_tvc), workchain_id: nil, initial_data: nil}
  end
  
  keys = nil
  if public_key && secret_key
    keys = {public: public_key, secret: secret_key}
  end
  
  signer = nil
  if keys
    signer = {type: 'Keys', public_key: nil, keys: keys, handle: nil}
  elsif External
    signer = {type: 'External', public_key: public_key, keys: nil, handle: nil}
  else
    signer = {type: 'None'}
  end

  call_set = nil
  if call_set_function_name
    call_set = {function_name: call_set_function_name, header: call_set_header, input: call_set_input}
  end

  payload = {abi: abi, address: address, deploy_set: deploy_set, call_set: call_set, signer: signer, processing_try_index: nil}
  callLibraryMethodSync(@client.abi.method(:encode_message), payload) do |response|
    return response.first.result
  end
end

def get_grams_from_giver_sync(client: nil, account_address: nil, value: 10_000_000_000, &block)
  test_address = "0:9cb911799a34982a27cb577ce694843f60b9e09fcba4f7fd7e040730acd59baa"
  server_address = client.context_config[:network][:server_address]
  raise 'Please, set client network for Giver work !' unless server_address
  if (env['use_giver'] || env["giver_abi_name"]) == 'GiverNodeSE'
    get_grams_from_giver_sync_node_se(client, account_address || test_address, value, &block)
  elsif (env['use_giver'] || env["giver_abi_name"]) == 'GiverNodeSE_v2'
    get_grams_from_giver_sync_node_se_v2(client, account_address || test_address, value, &block)
  elsif server_address[/net\.ton\.dev/]
    get_grams_from_giver_sync_net_dev(client, account_address || test_address, value, &block)
  else
    p "No Giver for this network: #{server_address}"
    block.call(nil) if block
    return false
  end

  tokens_received = false
  fuse_counter = 0
  while !tokens_received
    params_of_wait_for_collection = {collection: "accounts", filter: {"id": {"eq": account_address} }, result: "id balance(format: DEC)", timeout: nil}
    callLibraryMethodSync(client.net.method(:wait_for_collection), params_of_wait_for_collection) do |resp|
      if resp.first&.result
        balance = resp.first.result['result']['balance'] || 0
        if balance.to_i > 0
          tokens_received = true
        end
      end
    end
    fuse_counter += 1
    if fuse_counter > 20 && !tokens_received
      tokens_received = true
      return false
    end
    return true if tokens_received
  end
end

def get_grams_from_giver_sync_node_se(client, account_address, value, &block)
  p 'Giver SE start'
  wallet_address = env["giver_address"] || "0:841288ed3b55d9cdafa806807f02a0ae0c169aa5edfe88a789a6482429756a94"
  abi_name = env["giver_abi_name"]
  abi = { type: 'Serialized', value: read_abi(abi_name) }
  signer = {type: 'None'}
  call_set = {function_name: 'sendGrams', header: nil, input: {dest: account_address, amount: env['giver_amount'].to_i || value}}
  p call_set
  params_of_encoded_message = {abi: abi, address: wallet_address, call_set: call_set, deploy_set: nil, signer: signer, processing_try_index: nil}
  send_paylod = {message_encode_params: params_of_encoded_message, send_events: false}
  response = nil
  callLibraryMethodSync(client.processing.method(:process_message), send_paylod) do |resp|
    response = resp
  end
  raise response.first.error if response.first&.error
  raise response.last.error if response.last&.error
  p 'Giver SE - finished'
  block.call(response) if block
end

def get_grams_from_giver_sync_node_se_v2(client, account_address, value, &block)
  p 'Giver SE v2 start'
  wallet_address = env["giver_address"] || "0:b5e9240fc2d2f1ff8cbb1d1dee7fb7cae155e5f6320e585fcc685698994a19a5"
  abi_name = env["giver_abi_name"]
  abi = { type: 'Serialized', value: read_abi(abi_name) }
  keys = JSON.parse(File.read(project_root + "/spec/Fixtures/abi/#{abi_name}.keys.json"))
  signer = {type: 'Keys', keys: keys}
  call_set = {function_name: 'sendTransaction', header: nil, input: {dest: account_address, value: env['giver_amount'].to_i || value, bounce: false}}
  params_of_encoded_message = {abi: abi, address: wallet_address, call_set: call_set, deploy_set: nil, signer: signer, processing_try_index: nil}
  send_paylod = {message_encode_params: params_of_encoded_message, send_events: false}
  response = nil
  callLibraryMethodSync(client.processing.method(:process_message), send_paylod) do |resp|
    response = resp
  end
  p 'Giver SE v2 - finished'
  block.call(response) if block
end

def get_grams_from_giver_sync_net_dev(client, account_address, value, &block)
  p 'Giver NET - start'
  wallet_address = env["giver_address"]
  abi_name = env["giver_abi_name"]
  abi = { type: 'Serialized', value: read_abi(abi_name) }
  signer = {type: 'None'}
  call_set = {function_name: 'grant', header: nil, input: {addr: account_address}}
  params_of_encoded_message = {abi: abi, address: wallet_address, call_set: call_set, deploy_set: nil, signer: signer, processing_try_index: nil}
  send_paylod = {message_encode_params: params_of_encoded_message, send_events: false}
  response = nil
  callLibraryMethodSync(client.processing.method(:process_message), send_paylod) do |resp|
    response = resp
  end
  p 'Giver NET - finished'
  block.call(response) if block
end











