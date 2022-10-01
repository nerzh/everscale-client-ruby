require 'spec_helper'



describe TonClient::TonBinding do
  before(:all) do
    TonClient.configure { |config| config.ffi_lib(env['spec_ffi']) }
    config = TonClient::TonBinding.make_string('{}')
    @context = TonClient::TonBinding.tc_create_context(config)
    @id = TonClient::TonBinding.read_string_to_hash(@context)['result']
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
    result = TonClient::TonBinding.read_string_to_hash(context)
    expect(result).to be_a(Hash)
  end

  it 'tc_request_sync' do
    method_name = TonClient::TonBinding.make_string('client.version')
    payload = TonClient::TonBinding.make_string('{}')
    result = TonClient::TonBinding.tc_request_sync(@id, method_name, payload)
    # expect(result).to be_a(TonClient::TonBinding::TcStringHandleT)
    expect(result).to be_a(FFI::Pointer)
  end

  it 'async tc_request' do
    payload = TonClient::TonBinding.make_string('{}')
    method_name = TonClient::TonBinding.make_string('client.version')
    queue = Queue.new
    TonClient::TonBinding.tc_request(@id, method_name, payload, 999) do |request_id, data, response_type, finished|
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

  # it 'send_request' do
  #   queue = Queue.new
  #   TonClient::TonBinding.send_request(context: @id, method_name: 'client.version', payload: {}, request_id: 999) do |request_id, data, response_type, finished|
  #     queue.push request_id
  #     queue.push data
  #     queue.push response_type
  #     queue.push finished
  #   end
  #   request_id = queue.pop
  #   data = queue.pop
  #   response_type = queue.pop
  #   finished = queue.pop
    
  #   expect(request_id).to eq(999)
  #   expect(data).to be_a(TonClient::TonBinding::TcStringDataT)
  #   expect(response_type).to be_a(0.class)
  #   expect(finished == finished).to be_a(true.class)
  # end

  it 'async requestLibrary' do
    queue = Queue.new
    TonClient::TonBinding.requestLibrary(context: @id, method_name: 'client.version', payload: {}) do |response|
      queue.push response
    end
    response = queue.pop

    expect(response.result["version"].class).to eq(String)
    expect(response.error).to be_a(nil.class)
    expect(response.custom_response).to be_a(nil.class)
  end
end

