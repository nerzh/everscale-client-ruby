require 'ffi'
require "base64"
require 'json'
require 'byebug'
require 'dotenv'
require_relative '/Users/nerzh/mydata/ruby_projects/gems/ton-client-ruby/lib/ton-client-ruby/Helpers/CommonHelpers.rb'
require_relative '/Users/nerzh/mydata/ruby_projects/gems/ton-client-ruby/lib/ton-client-ruby/Binding/struct.rb'
require_relative '/Users/nerzh/mydata/ruby_projects/gems/ton-client-ruby/lib/ton-client-ruby/Binding/binding.rb'
require_relative '/Users/nerzh/mydata/ruby_projects/gems/ton-client-ruby/lib/ton-client-ruby/Client/Context.rb'
require_relative '/Users/nerzh/mydata/ruby_projects/gems/ton-client-ruby/lib/ton-client-ruby/Client/Client.rb'
require_relative '/Users/nerzh/mydata/ruby_projects/gems/ton-client-ruby/lib/ton-client-ruby/Client/Crypto.rb'
require_relative '/Users/nerzh/mydata/ruby_projects/gems/ton-client-ruby/lib/ton-client-ruby/Client/Abi.rb'
require_relative '/Users/nerzh/mydata/ruby_projects/gems/ton-client-ruby/lib/ton-client-ruby/Client/Boc.rb'
require_relative '/Users/nerzh/mydata/ruby_projects/gems/ton-client-ruby/lib/ton-client-ruby/Client/Net.rb'
require_relative '/Users/nerzh/mydata/ruby_projects/gems/ton-client-ruby/lib/ton-client-ruby/Client/Processing.rb'
require_relative '/Users/nerzh/mydata/ruby_projects/gems/ton-client-ruby/lib/ton-client-ruby/Client/Tvm.rb'
require_relative '/Users/nerzh/mydata/ruby_projects/gems/ton-client-ruby/lib/ton-client-ruby/Client/Utils.rb'

p 'REQUIRE OK'

# require 'ton-client-ruby/version'

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
