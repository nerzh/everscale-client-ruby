require_relative '/Users/nerzh/mydata/ruby_projects/gems/ton-client-ruby/lib/ton-client-ruby.rb'


TonClient.configure do |config|
  # config.ffi_lib('/Users/nerzh/mydata/trash/ton/TON-SDK/target/debug/libton_client.' + FFI::Platform::LIBSUFFIX)
  config.ffi_lib('/Users/nerzh/mydata/trash/ton/TON-SDK-1.0.0/target/debug/libton_client.' + FFI::Platform::LIBSUFFIX)
end

client = TonClient.create()

TonClient.main(client)

client.destroy_context()