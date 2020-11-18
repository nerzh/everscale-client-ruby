require 'spec_helper'



describe TonClient::Context do
  before(:all) do
    TonClient.configure { |config| config.ffi_lib(env['spec_ffi']) }
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


















