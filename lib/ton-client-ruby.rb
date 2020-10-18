require 'ffi'
require "base64"
require 'json'
require 'byebug'
require_relative '/Users/nerzh/mydata/ruby_projects/gems/ton-client-ruby/lib/ton-client-ruby/Helpers/CommonHelpers.rb'
require_relative '/Users/nerzh/mydata/ruby_projects/gems/ton-client-ruby/lib/ton-client-ruby/Binding/struct.rb'
require_relative '/Users/nerzh/mydata/ruby_projects/gems/ton-client-ruby/lib/ton-client-ruby/Binding/binding.rb'
require_relative '/Users/nerzh/mydata/ruby_projects/gems/ton-client-ruby/lib/ton-client-ruby/Client/Context.rb'
require_relative '/Users/nerzh/mydata/ruby_projects/gems/ton-client-ruby/lib/ton-client-ruby/Client/Client.rb'
require_relative '/Users/nerzh/mydata/ruby_projects/gems/ton-client-ruby/lib/ton-client-ruby/Client/Crypto.rb'
require_relative '/Users/nerzh/mydata/ruby_projects/gems/ton-client-ruby/lib/ton-client-ruby/Client/Abi.rb'

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

  def self.ffi_lib(dylib_path)
    TonBinding.ffi_lib(dylib_path)
    TonBinding.setup_bindings()
    @@configured = true
  end

  def self.create(config: {})
    check_configuration
    Client.new(context: Context.new(config: config))
  end

  

















  def self.main(client)
    return
    # SETUP
    # Common.new(context: context).setup
    p Common.new(context: context).version

    crypto = Crypto.new(context: context)
    p crypto.math_factorize('17ED48941A08F981')
    p crypto.random_generateBytes({ length: 32, outputEncoding: Crypto::TONOutputEncoding[:Hex] })
    p crypto.ed_25519_keypair
    p crypto.sha512({ text: 'Message to hash with sha 512' })
    p crypto.sha256({ text: 'Message to hash with sha 256' })
    j = {
        password: {text: 'Test Password'},
        salt: {text: 'Test Salt'},
        logN: 10,
        r: 8,
        p: 16,
        dkLen: 64,
        outputEncoding: Crypto::TONOutputEncoding[:Hex]
    }
    # p crypto.scrypt(j)
    p crypto.nacl_box_keypair_fromSecretKey('8fb4f2d256e57138fb310b0a6dac5bbc4bee09eb4821223a720e5b8e1f3dd674')
    p crypto.nacl_sign_keypair_fromSecretKey('8fb4f2d256e57138fb310b0a6dac5bbc4bee09eb4821223a720e5b8e1f3dd674')
    # p crypto.mnemonic_words()
    p crypto.mnemonic_verify?({ phrase: 'one two' })

    j = {
        dictionary: Crypto::TONMnemonicDictionary[:ENGLISH],
        wordCount: 12,
        phrase: 'abuse boss fly battle rubber wasp afraid hamster guide essence vibrant tattoo'
    }
    p crypto.hdkey_xprv_from_mnemonic(j)
    p crypto.ton_crc16({ text: 'Message to hash with sha 256' })



    # p TonBinding.send_request(context: context, method_name: 'queries.query', json: '{"table": "accounts", "filter": "{}", "result": "id balance(format:DEC) "}')

    return
    # context = TonBinding.tc_create_context()

    # method_name = 'crypto.mnemonic.derive.sign.keys'
    # json = '{"phrase": "unit follow zone decline glare flower crisp vocal adapt magic much mesh cherry teach mechanic rain float vicious solution assume hedgehog rail sort chuckle"}'

    # method_name = 'queries.query'
    # json = '{"table": "accounts", "filter": "{}", "result": "id balance(format:DEC) "}'

    method_name = 'setup'
    json = '{ "servers": ["net.ton.dev"] }'
    
    a = TonBinding::InteropString.new
    pointer = FFI::MemoryPointer.from_string(method_name)
    a[:content] = pointer
    a[:len] = method_name.bytesize

    b = TonBinding::InteropString.new
    pointer2 = FFI::MemoryPointer.from_string(json)
    b[:content] = pointer2
    b[:len] = json.bytesize

    resp = TonBinding.tc_json_request(context, a, b)
    read = TonBinding.tc_read_json_response(resp)
    
    p read[:result_json][:content].read_string(read[:result_json][:len]) if read[:result_json][:content].address > 1
    p read[:error_json][:content].read_string(read[:error_json][:len]) if read[:error_json][:content].address > 1

    

    method_name = 'queries.query'
    json = '{"table": "accounts", "filter": "{}", "result": "id balance(format:DEC) "}'

    method_name = 'version'
    json = ''

    a = TonBinding::InteropString.new
    pointer = FFI::MemoryPointer.from_string(method_name)
    a[:content] = pointer
    a[:len] = method_name.bytesize

    b = TonBinding::InteropString.new
    pointer2 = FFI::MemoryPointer.from_string(json)
    b[:content] = pointer2
    b[:len] = json.bytesize

    resp = TonBinding.tc_json_request(context, a, b)
    read = TonBinding.tc_read_json_response(resp)
    
    p read[:result_json][:content].read_string(read[:result_json][:len]) if read[:result_json][:content].address > 1
    p read[:error_json][:content].read_string(read[:error_json][:len]) if read[:error_json][:content].address > 1
  ensure
    client.destroy_context()
    # p context.id
    # TonBinding.tc_destroy_context(context.id)
    # TON::Client.free(context) if context
    # TON::Client.free(pointer) if pointer
    # TON::Client.free(pointer2) if pointer2
    # TON::Client.free(resp) if resp
  end
end
