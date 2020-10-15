require 'spec_helper'



describe TonClient::Context do
  before(:all) do
    ffi_path = ENV['SPEC_FFI']
    
    TonClient.configure do |config|
      config.ffi_lib(ffi_path)
    end
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






describe TonClient::Common do
  before(:all) do
    ffi_path = ENV['SPEC_FFI']
    
    TonClient.configure do |config|
      config.ffi_lib(ffi_path)
    end
    TonClient.create_context()
    @common = TonClient::Common.new(context: TonClient.context)
    @common.setup
  end

  after(:all) do
    TonClient.destroy_context()
  end

  it 'setup' do
    expect(@common.setup(network: ["net.ton.dev"])).to be_a(nil.class)
  end

  it 'version' do
    p @common.version
    expect(@common.version).to be_a(String)
  end
end