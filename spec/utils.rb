require 'spec_helper'


describe TonClient::Utils do
  before(:all) do
    @client = make_client
    @account_id = "fcb91a3a3816d0f7b8c2c76108b8a9bc5a6b7a55bd79f8ab101c52db29232260"
    @hex = "-1:fcb91a3a3816d0f7b8c2c76108b8a9bc5a6b7a55bd79f8ab101c52db29232260"
    @hexWorkchain0 = "0:fcb91a3a3816d0f7b8c2c76108b8a9bc5a6b7a55bd79f8ab101c52db29232260"
    @base64 = "Uf/8uRo6OBbQ97jCx2EIuKm8Wmt6Vb15+KsQHFLbKSMiYG+9"
    @base64_url = "kf_8uRo6OBbQ97jCx2EIuKm8Wmt6Vb15-KsQHFLbKSMiYIny"
  end

  it 'account_id_to_hex' do
    format = {type: 'Hex', url: nil, test: nil, bounce: nil}
    payload = {address: @account_id, output_format: format}
    callLibraryMethodSync(@client.utils.method(:convert_address), payload) do |response|
      expect(response.first.result['address']).to eq(@hexWorkchain0)
    end
  end

  it 'account_id_to_account_id' do
    format = {type: 'AccountId', url: nil, test: nil, bounce: nil}
    payload = {address: @account_id, output_format: format}
    callLibraryMethodSync(@client.utils.method(:convert_address), payload) do |response|
      expect(response.first.result['address']).to eq(@account_id)
    end
  end

  it 'hex_to_base64' do
    format = {type: 'Base64', url: false, test: false, bounce: false}
    payload = {address: @hex, output_format: format}
    callLibraryMethodSync(@client.utils.method(:convert_address), payload) do |response|
      expect(response.first.result['address']).to eq(@base64)
    end
  end

  it 'base64_to_base64_url' do
    format = {type: 'Base64', url: true, test: true, bounce: true}
    payload = {address: @base64, output_format: format}
    callLibraryMethodSync(@client.utils.method(:convert_address), payload) do |response|
      expect(response.first.result['address']).to eq(@base64_url)
    end
  end

  it 'base64_url_to_hex' do
    format = {type: 'Hex', url: nil, test: nil, bounce: nil}
    payload = {address: @base64_url, output_format: format}
    callLibraryMethodSync(@client.utils.method(:convert_address), payload) do |response|
      expect(response.first.result['address']).to eq(@hex)
    end
  end
  
end



















