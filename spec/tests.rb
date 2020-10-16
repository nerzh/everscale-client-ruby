require 'spec_helper'



describe TonClient::Context do
  before(:all) do
    TonClient.configure { |config| config.ffi_lib(ENV['SPEC_FFI']) }
  end

  it 'create context' do
    context = TonClient::Context.new
    expect(context.id).to be_a(0.class)
  end

  it 'destroy context' do
    context = TonClient::Context.new
    expect(context.destroy).to be_a(nil.class)
  end
end

describe TonClient::Client do
  before(:all) do
    TonClient.configure { |config| config.ffi_lib(ENV['SPEC_FFI']) }
  end

  it 'create client' do
    client = TonClient.create(config: {network: {server_address: "net.ton.dev"}})
    expect(client.context.id).to be_a(0.class)
  end

  it 'destroy context' do
    client = TonClient.create(config: {network: {server_address: "net.ton.dev"}})
    expect(client.destroy_context).to be_a(nil.class)
  end

  it 'check version' do
    client = TonClient.create(config: {network: {server_address: "net.ton.dev"}})
    expect(client.version).to be_a(String)
  end
end

describe TonClient::TonBinding do
  before(:all) do
    TonClient.configure { |config| config.ffi_lib(ENV['SPEC_FFI']) }
  end

  it 'tc_create_context + read_string + read_string_to_hash' do
    config = TonClient::TonBinding.make_string('{}')
    context = TonClient::TonBinding.tc_create_context(config)
    result = TonClient::TonBinding.read_string_to_hash(context)
    expect(result['result']).to be_a(Integer)
  end

  it 'tc_destroy_context' do
    config = TonClient::TonBinding.make_string('{}')
    context = TonClient::TonBinding.tc_create_context(config)
    result  = TonClient::TonBinding.read_string_to_hash(context)
    expect(TonClient::TonBinding.tc_destroy_context(result['result'])).to be_a(nil.class)
  end

  it 'make_string' do
    word = "Hello"
    result = TonClient::TonBinding.make_string(word)
    expect(result[:len]).to eq(word.bytesize)
    expect(result[:content].read_string(word.bytesize)).to eq("Hello")
  end

  it 'read_string_to_hash' do
    config = TonClient::TonBinding.make_string('{}')
    context = TonClient::TonBinding.tc_create_context(config)
    result  = TonClient::TonBinding.read_string_to_hash(context)
    expect(result).to be_a(Hash)
  end

  it 'tc_request_sync' do
    config = TonClient::TonBinding.make_string('{}')
    context = TonClient::TonBinding.tc_create_context(config)
    id = TonClient::TonBinding.read_string_to_hash(context)['result']
    method_name = TonClient::TonBinding.make_string('client.version')
    payload = config
    result = TonClient::TonBinding.tc_request_sync(id, method_name, payload)
    expect(result).to be_a(TonClient::TonBinding::TcStringHandleT)
  end

  it 'async tc_request' do
    config = TonClient::TonBinding.make_string('{}')
    context = TonClient::TonBinding.tc_create_context(config)
    id = TonClient::TonBinding.read_string_to_hash(context)['result']
    method_name = TonClient::TonBinding.make_string('client.version')
    payload = config
    queue = Queue.new
    TonClient::TonBinding.tc_request(id, method_name, payload, 999) do |request_id, data, response_type, finished|
      queue.push request_id
      queue.push data
      queue.push response_type
      queue.push finished
    end
    request_id = queue.pop
    data = queue.pop
    response_type = queue.pop
    finished = queue.pop
    
    expect(request_id).to eq(999)
    expect(data).to be_a(TonClient::TonBinding::TcStringDataT)
    expect(response_type).to be_a(0.class)
    expect(finished == finished).to be_a(true.class)
  end
end




# describe TonClient::Common do
#   before(:all) do
#     ffi_path = ENV['SPEC_FFI']
    
#     TonClient.configure do |config|
#       config.ffi_lib(ffi_path)
#     end
#     TonClient.create_context()
#     @common = TonClient::Common.new(context: TonClient.context)
#     @common.setup
#   end

#   after(:all) do
#     TonClient.destroy_context()
#   end

#   it 'setup' do
#     expect(@common.setup(network: ["net.ton.dev"])).to be_a(nil.class)
#   end

#   it 'version' do
#     p @common.version
#     expect(@common.version).to be_a(String)
#   end
# end