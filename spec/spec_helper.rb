require 'bundler/setup'
Bundler.setup

require 'ton-client-ruby' # and any other gems you need

RSpec.configure do |config|
  config.full_backtrace = true
  # some (optional) config here
end

def requestLibrarySync(context: 1, method_name: '', payload: {})
  responses = []
  queue = Queue.new
  TonClient::TonBinding.requestLibrary(context: context, method_name: method_name, payload: payload) do |response|
    responses << response
    queue.push 1 if response.finished == true
  end
  queue.pop
  yield(responses)
end

def callLibraryMethodSync(method, *args)
  responses = []
  queue = Queue.new
  method.call(*args) do |response|
    responses << response
    queue.push 1 if response.finished == true
  end
  queue.pop
  yield(responses)
end