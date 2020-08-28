module TonClient
  
  class Crypto

    TONOutputEncoding = {
      Text: 'Text',
      Hex: 'Hex',
      HexUppercase: 'HexUppercase',
      Base64: 'Base64',
    }

    TONMnemonicDictionary = {
      TON: 0,
      ENGLISH: 1,
      CHINESE_SIMPLIFIED: 2,
      CHINESE_TRADITIONAL: 3,
      FRENCH: 4,
      ITALIAN: 5,
      JAPANESE: 6,
      KOREAN: 7,
      SPANISH: 8,
    }

    attr_reader :context, :core

    def initialize(context: TonClient.context, core: TonClient::TonBinding)
      @context = context
      @core = core
    end



    # MATH

    # payload = '17ED48941A08F981'
    def math_factorize(payload)
      core.send_request(context: context, method_name: 'crypto.math.factorize', payload: payload)
    end

    # payload = { base: baseHex, exponent: exponentHex, modulus: modulusHex}
    def math_modularPower(payload)
      core.send_request(context: context, method_name: 'crypto.math.modularPower', payload: payload)
    end


    
    # RANDOM

    # payload = {length: 32, outputEncoding: TONOutputEncoding.Hex}
    def random_generateBytes(payload)
      core.send_request(context: context, method_name: 'crypto.random.generateBytes', payload: payload)
    end

    # payload =
    def ed_25519_keypair
      core.send_request(context: context, method_name: 'crypto.ed25519.keypair')
    end



    # SHA

    # payload = { text: 'Message to hash with sha 512' }
    def sha512(payload)
      payload[:message] = fixInputMessage(payload)
      payload[:outputEncoding] = payload[:outputEncoding] || TONOutputEncoding[:Hex]
      core.send_request(context: context, method_name: 'crypto.sha512', payload: payload)
    end

    # payload = { text: 'Message to hash with sha 256' }
    def sha256(payload)
      payload[:message] = fixInputMessage(payload)
      payload[:outputEncoding] = payload[:outputEncoding] || TONOutputEncoding[:Hex]
      core.send_request(context: context, method_name: 'crypto.sha256', payload: payload)
    end

    # payload = { text: 'Message to hash with crc16' }
    def ton_crc16(payload)
      core.send_request(context: context, method_name: 'crypto.ton_crc16', payload: payload)
    end



    # SCRYPT

    # payload = {
    #     password: { text: 'Test Password' },
    #     salt: { text: 'Test Salt' },
    #     logN: 10,
    #     r: 8,
    #     p: 16,
    #     dkLen: 64,
    #     outputEncoding: TONOutputEncoding.Hex
    # }
    def scrypt(payload)
      payload[:password] = fixInputMessage(payload[:password])
      payload[:salt] = fixInputMessage(payload[:salt])
      payload[:outputEncoding] = payload[:outputEncoding] || TONOutputEncoding[:Hex]
      core.send_request(context: context, method_name: 'crypto.scrypt', payload: payload)
    end



    # NACL KEYS

    # payload =
    def nacl_box_keypair
      core.send_request(context: context, method_name: 'crypto.nacl.box.keypair')
    end

    # payload = '8fb4f2d256e57138fb310b0a6dac5bbc4bee09eb4821223a720e5b8e1f3dd674'
    def nacl_box_keypair_fromSecretKey(payload)
      core.send_request(context: context, method_name: 'crypto.nacl.box.keypair.fromSecretKey', payload: payload)
    end

    # payload =
    def nacl_sign_keypair
      core.send_request(context: context, method_name: 'crypto.nacl.sign.keypair')
    end

    # payload = '8fb4f2d256e57138fb310b0a6dac5bbc4bee09eb4821223a720e5b8e1f3dd674'
    def nacl_sign_keypair_fromSecretKey(payload)
      core.send_request(context: context, method_name: 'crypto.nacl.sign.keypair.fromSecretKey', payload: payload)
    end

    


    # NACL BOX

    # payload = {
    #     message: {text: 'Test Message'},
    #     nonce: 'cd7f99924bf422544046e83595dd5803f17536f5c9a11746',
    #     theirPublicKey: 'c4e2d9fe6a6baf8d1812b799856ef2a306291be7a7024837ad33a8530db79c6b',
    #     secretKey: 'd9b9dc5033fb416134e5d2107fdbacab5aadb297cb82dbdcd137d663bac59f7f'
    # }
    def nacl_box(payload)
      payload[:message] = fixInputMessage(payload[:message])
      core.send_request(context: context, method_name: 'crypto.nacl.box', payload: payload)
    end

    # payload = {
    #     message: { hex: '962e17103e24c7fa63436a9d3f4791d9dfcadf4b8df78be83400f1c0' },
    #     nonce: 'cd7f99924bf422544046e83595dd5803f17536f5c9a11746',
    #     theirPublicKey: 'c4e2d9fe6a6baf8d1812b799856ef2a306291be7a7024837ad33a8530db79c6b',
    #     secretKey: 'd9b9dc5033fb416134e5d2107fdbacab5aadb297cb82dbdcd137d663bac59f7f',
    #     outputEncoding: TONOutputEncoding.Text
    # }
    def nacl_box_open(payload)
      payload[:message] = fixInputMessage(payload[:message])
      core.send_request(context: context, method_name: 'crypto.nacl.box.open', payload: payload)
    end

    # payload = {
    #     message: { hex: '24bede8ca59ed8a5e6aec9ece35c9f5e8405d2dfc2d50f111b2cd0d8' },
    #     nonce: '2a33564717595ebe53d91a785b9e068aba625c8453a76e45',
    #     key: '8f68445b4e78c000fe4d6b7fc826879c1e63e3118379219a754ae66327764bd8',
    #     outputEncoding: TONOutputEncoding.Text
    # }
    def nacl_secret_box(payload)
      payload[:message] = fixInputMessage(payload[:message])
      core.send_request(context: context, method_name: 'crypto.nacl.secret.box', payload: payload)
    end

    # payload = {
    #     message: { hex: '24bede8ca59ed8a5e6aec9ece35c9f5e8405d2dfc2d50f111b2cd0d8' },
    #     nonce: '2a33564717595ebe53d91a785b9e068aba625c8453a76e45',
    #     key: '8f68445b4e78c000fe4d6b7fc826879c1e63e3118379219a754ae66327764bd8',
    #     outputEncoding: TONOutputEncoding.Text
    # }
    def nacl_secret_box_open(payload)
      payload[:message] = fixInputMessage(payload[:message])
      core.send_request(context: context, method_name: 'crypto.nacl.secret.box.open', payload: payload)
    end



    # NACL SIGN

    # payload = {
    #     message: fixInputMessage(message),
    #     key: '56b6a77093d6fdf14e593f36275d872d75de5b341942376b2a08759f3cbae78f1869b7ef29d58026217e9cf163cbfbd0de889bdf1bf4daebf5433a312f5b8d6e',
    #     outputEncoding: TONOutputEncoding.Hex
    # }
    def nacl_sign(payload)
      payload[:message] = fixInputMessage(payload[:message])
      payload[:outputEncoding] = payload[:outputEncoding] || TONOutputEncoding[:Hex]
      core.send_request(context: context, method_name: 'crypto.nacl.sign', payload: payload)
    end

    # payload = {
    #     message: fixInputMessage(message),
    #     key: '56b6a77093d6fdf14e593f36275d872d75de5b341942376b2a08759f3cbae78f1869b7ef29d58026217e9cf163cbfbd0de889bdf1bf4daebf5433a312f5b8d6e',
    #     outputEncoding: TONOutputEncoding.Text
    # }
    def nacl_sign_open(payload)
      payload[:message] = fixInputMessage(payload[:message])
      payload[:outputEncoding] = payload[:outputEncoding] || TONOutputEncoding[:Hex]
      core.send_request(context: context, method_name: 'crypto.nacl.sign.open', payload: payload)
    end

    # payload = {
    #     message: fixInputMessage(message),
    #     key: '56b6a77093d6fdf14e593f36275d872d75de5b341942376b2a08759f3cbae78f1869b7ef29d58026217e9cf163cbfbd0de889bdf1bf4daebf5433a312f5b8d6e',
    #     outputEncoding: TONOutputEncoding.Text
    # }
    def nacl_sign_detached(payload)
      payload[:message] = fixInputMessage(payload[:message])
      payload[:outputEncoding] = payload[:outputEncoding] || TONOutputEncoding[:Hex]
      core.send_request(context: context, method_name: 'crypto.nacl.sign.detached', payload: payload)
    end

    # payload = '' keys.public
    def ton_public_key_string(payload)
      core.send_request(context: context, method_name: 'crypto.ton_public_key_string', payload: payload)
    end



    # MNEMONIC

    # payload = {
    #     dictionary?: TONMnemonicDictionaryType,
    #     wordCount?: TONMnemonicWordCountType,
    # }
    def mnemonic_words(payload = {})
      core.send_request(context: context, method_name: 'crypto.mnemonic.words', payload: payload)
    end

    # payload = {
    #     entropy: { hex: '00112233445566778899AABBCCDDEEFF' },
    #     dictionary: TONMnemonicDictionary.ENGLISH,
    #     wordCount: 12,
    # }
    def mnemonic_from_random(payload = {})
      core.send_request(context: context, method_name: 'crypto.mnemonic.from.random', payload: payload)
    end

    # payload = { phrase: 'one two' }
    def mnemonic_verify?(payload)
      core.send_request(context: context, method_name: 'crypto.mnemonic.verify', payload: payload)
    end
    alias_method :mnemonic_isValid?, :mnemonic_verify?

    # payload = {
    #     phrase: phrase2,
    # }
    def mnemonic_derive_sign_keys(payload)
      core.send_request(context: context, method_name: 'crypto.mnemonic.derive.sign.keys', payload: payload)
    end

    # payload = {
    #     entropy: { hex: '00112233445566778899AABBCCDDEEFF' },
    #     dictionary: TONMnemonicDictionary.ENGLISH,
    #     wordCount: 12,
    # }
    def mnemonic_from_entropy(payload)
      core.send_request(context: context, method_name: 'crypto.mnemonic.from.entropy', payload: payload)
    end

    


    # HDKeys

    # payload = {
    #     dictionary: TONMnemonicDictionary.ENGLISH,
    #     wordCount: 12,
    #     phrase: 'abuse boss fly battle rubber wasp afraid hamster guide essence vibrant tattoo'
    # }
    def hdkey_xprv_from_mnemonic(payload)
      core.send_request(context: context, method_name: 'crypto.hdkey.xprv.from.mnemonic', payload: payload)
    end

    # payload = {
    #     serialized: crypto.hdkey_xprv_from_mnemonic(...),
    #     index: 0,
    #     hardened: false,
    #     compliant: false
    # }
    def hdkey_xprv_derive(payload)
      core.send_request(context: context, method_name: 'crypto.hdkey.xprv.derive', payload: payload)
    end

    # payload = {
    #     serialized: crypto.hdkey_xprv_from_mnemonic(...),
    #     path: "m/44'/60'/0'/0'",
    #     compliant: false
    # }
    def hdkey_xprv_derive_path(payload)
      core.send_request(context: context, method_name: 'crypto.hdkey.xprv.derive.path', payload: payload)
    end

    # payload = { serialized: '518afc6489b61d4b738ee9ad9092815fa014ffa6e9a280fa17f84d95f31adb91' }
    def hdkey_xprv_secret(payload)
      core.send_request(context: context, method_name: 'crypto.hdkey.xprv.secreth', payload: payload)
    end

    # payload = { serialized: '518afc6489b61d4b738ee9ad9092815fa014ffa6e9a280fa17f84d95f31adb91' }
    def hdkey_xprv_public(payload)
      core.send_request(context: context, method_name: 'crypto.hdkey.xprv.public', payload: payload)
    end



    private

    def fixInputMessage(message)
      if message[:text]
        { base64: Base64.encode64(message[:text].force_encoding('UTF-8')).strip }
      else
        message
      end
    end
    
  end
end









