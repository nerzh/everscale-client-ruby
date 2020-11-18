require 'spec_helper'


describe TonClient::Processing do
  before(:all) do
    @client = make_client
  end

  it 'wait_for_transaction' do
    abi_name = "Events"
    abi = { type: 'Serialized', value: read_abi(abi_name) }
    tvc = read_tvc(abi_name)
    keys = generate_keys
    encoded_message = abiEncodeMessage(
      name_abi: abi_name, 
      name_tvc: abi_name, 
      address: nil, 
      public_key: keys['public'], 
      secret_key: keys['secret'], 
      call_set_function_name: "constructor",
      call_set_header: {expire: nil, time: nil, pubkey: keys['public']},
      call_set_input: nil
    )

    positive_balance = get_grams_from_giver_sync(client: @client, account_address: encoded_message['address'])
    expect(positive_balance).to eq(true)

    params_of_send_message = {message: encoded_message['message'], abi: abi, send_events: true}
    result_of_send_message = nil
    callLibraryMethodSync(@client.processing.method(:send_message), params_of_send_message) do |response|
      result_of_send_message = response.first.result
    end

    params_of_wait_for_transaction = {abi: abi, message: encoded_message['message'], shard_block_id: result_of_send_message['shard_block_id'], send_events: true}
    callLibraryMethodSync(@client.processing.method(:wait_for_transaction), params_of_wait_for_transaction) do |response|
      expect(response.first.result['out_messages'].size).to eq(0)
      expect(response.first.result['decoded']).to eq({"out_messages" => [], "output" => nil})
    end    
  end

  it 'process_mesage' do
    abi_name = "Events"
    abi = { type: 'Serialized', value: read_abi(abi_name) }
    tvc = read_tvc(abi_name)
    keys = generate_keys
    result = abiEncodeMessage(
      name_abi: abi_name, 
      name_tvc: abi_name, 
      address: nil, 
      public_key: keys['public'], 
      secret_key: keys['secret'], 
      call_set_function_name: "constructor",
      call_set_header: {expire: nil, time: nil, pubkey: keys['public']},
      call_set_input: nil
    )

    positive_balance = get_grams_from_giver_sync(client: @client, account_address: result['address'])
    expect(positive_balance).to eq(true)

    payload_encode_message = {
      abi: abi,
      address: nil,
      deploy_set: {tvc: tvc, workchain_id: nil, initial_data: nil},
      call_set: {function_name: "constructor", header: {expire: nil, time: nil, pubkey: keys['public']}, input: nil},
      signer: {type: 'Keys', public_key: nil, keys: keys, handle: nil},
      processing_try_index: nil
    }
    payload_process_message = {message_encode_params: payload_encode_message, send_events: true}
    result_of_process_message = nil
    callLibraryMethodSync(@client.processing.method(:process_message), payload_process_message) do |response|
      expect(response.first.result['fees']['total_account_fees'].to_f).to be > 0
      expect(response.first.result['out_messages'].size).to eq(0)
      expect(response.first.result['decoded']).to eq({"out_messages" => [], "output" => nil})
    end
  end
end



















