require 'spec_helper'



describe TonClient::Client do
  before(:all) do
    @client = make_client
  end

  it 'check version' do
    callLibraryMethodSync(@client.method(:version)) do |response|
      p response.first.result['version']
      expect(response.first.result['version']).to be_a(String)
    end
  end

  it 'create client' do
    client = TonClient.create(config: {network: {server_address: "net.ton.dev"}})
    expect(client.context).to be_a(0.class)
  end

  it 'get_api_reference' do
    callLibraryMethodSync(@client.method(:get_api_reference)) do |response|
      expect(response.first.result['api']).to be_a(Hash)
    end
  end
end

