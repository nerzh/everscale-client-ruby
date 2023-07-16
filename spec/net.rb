require 'spec_helper'
require 'byebug'


describe TonClient::Net do
  before(:all) do
    @client = make_client
  end

  it 'query_collection' do
    payload = {
      collection: "messages",
      filter: { created_at: {gt: 1562342740} },
      result: "body created_at",
      order: nil,
      limit: nil
    }
    callLibraryMethodSync(@client.net.method(:query_collection), payload) do |response|
      expect(response.first.result['result'].first['created_at']).to be > 1562342740
    end
  end

  it 'wait_for_collection' do
    now = Time.now.to_i
    payload = {collection: "transactions", filter: {now: {gt: now}}, result: "id now", timeout: nil}
    Thread.new do
      sleep 2
      (1..5).each { get_grams_from_giver_sync(client: @client) }
    end
    callLibraryMethodSync(@client.net.method(:wait_for_collection), payload) do |response|
      expect(response.first.result['result']['now']).to be > now
    end
  end

  it 'subscribe_collection' do
    queue = Queue.new
    payload = {collection: "transactions", filter: nil, result: "id account_addr"}
    result = nil
    @client.net.subscribe_collection(payload) do |response|
      result = response.result
      queue.push 1
    end
    queue.pop
    expect(result['handle'].class).to be(Integer)
    # unsubscribe
    @client.net.unsubscribe({handle: result['handle']}) do |response|
      queue.push 1
    end
    queue.pop
  end
end



















