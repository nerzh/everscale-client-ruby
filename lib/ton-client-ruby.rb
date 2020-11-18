require 'ffi'
require "base64"
require 'json'
require 'byebug'
require 'dotenv'
require 'ton-client-ruby/Helpers/CommonHelpers.rb'
require 'ton-client-ruby/Binding/struct.rb'
require 'ton-client-ruby/Binding/binding.rb'
require 'ton-client-ruby/Client/Context.rb'
require 'ton-client-ruby/Client/Client.rb'
require 'ton-client-ruby/Client/Crypto.rb'
require 'ton-client-ruby/Client/Abi.rb'
require 'ton-client-ruby/Client/Boc.rb'
require 'ton-client-ruby/Client/Net.rb'
require 'ton-client-ruby/Client/Processing.rb'
require 'ton-client-ruby/Client/Tvm.rb'
require 'ton-client-ruby/Client/Utils.rb'
require 'ton-client-ruby/version'

module TonClient

  @@configured = false

  def self.check_configuration
    raise "Not configured! Please configure TonClient: call ffi_lib(dylib_path)" unless !!@@configured
  end

  def self.configure
    yield self
  end

  def self.ffi_lib(dylib_path = nil)
    TonBinding.ffi_lib(dylib_path)
    TonBinding.setup_bindings()
    @@configured = true
  end

  def self.create(config: {})
    check_configuration
    Client.new(context: Context.new(config: config))
  end
end
