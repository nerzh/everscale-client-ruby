require 'spec_helper'


describe TonClient::Crypto do
  before(:all) do
    @client = make_client
  end

  it 'factorize' do
    payload = {composite: '17ED48941A08F981'}
    callLibraryMethodSync(@client.crypto.method(:factorize), payload) do |response|
      expect(response.first.result['factors']).to eq(["494C553B", "53911073"])
    end
  end

  it 'modular_power' do
    payload = {base: '0123456789ABCDEF', exponent: '0123', modulus: '01234567'}
    callLibraryMethodSync(@client.crypto.method(:modular_power), payload) do |response|
      expect(response.first.result['modular_power']).to eq('63bfdf')
    end
  end

  it 'ton_crc16' do
    payload = {data: 'MHgzMSAweDMyIDB4MzMgMHgzNCAweDM1IDB4MzYgMHgzNyAweDM4IDB4Mzk='}
    callLibraryMethodSync(@client.crypto.method(:ton_crc16), payload) do |response|
      expect(response.first.result['crc']).to eq(63574)
    end
  end

  it 'generate_random_bytes' do
    payload = {length: 32}
    callLibraryMethodSync(@client.crypto.method(:generate_random_bytes), payload) do |response|
      expect(response.first.result['bytes'].size).to eq(44)
    end
  end

  it 'convert_public_key_to_ton_safe_format' do
    payload = {public_key: 'd007e112febb206f0871e6b135fb2047ad58e77329035457c0e8b7dfc110294a'}
    callLibraryMethodSync(@client.crypto.method(:convert_public_key_to_ton_safe_format), payload) do |response|
      expect(response.first.result['ton_public_key']).to eq('PubQB-ES_rsgbwhx5rE1-yBHrVjncykDVFfA6LffwRApSsiQ')
    end
  end

  it 'generate_random_sign_keys' do
    callLibraryMethodSync(@client.crypto.method(:generate_random_sign_keys)) do |response|
      expect(response.first.result['public']).to be_a(String)
      expect(response.first.result['secret']).to be_a(String)
      expect(response.first.result['public'].size).to eq(64)
      expect(response.first.result['secret'].size).to eq(64)
    end
  end

  it 'sign' do
    payload = {unsigned: encode_to_base64("Hello"), keys: {"public"=>"a5c367411a00ab0b542d118649de388b43ce4b7fa6dae2bb9243c6ad9aca7661", "secret"=>"254c097277e9dd09d16152ee85abde4be54030db9930e38bf7069e4684ac10bb"}}
    callLibraryMethodSync(@client.crypto.method(:sign), payload) do |response|
      expect(response.first.result['signed']).to eq('JvgdakMHpOdw7PKJX/IMQDygYJxt/kzEge0ebJHXx7H8eUOYMcL7sN0YBfwP/QZ0Z8XpffpyDJdwLpTErtnCDEhlbGxv')
      expect(response.first.result['signature']).to eq('26f81d6a4307a4e770ecf2895ff20c403ca0609c6dfe4cc481ed1e6c91d7c7b1fc79439831c2fbb0dd1805fc0ffd067467c5e97dfa720c97702e94c4aed9c20c')
    end
  end

  it 'verify_signature' do
    payload = {signed: 'JvgdakMHpOdw7PKJX/IMQDygYJxt/kzEge0ebJHXx7H8eUOYMcL7sN0YBfwP/QZ0Z8XpffpyDJdwLpTErtnCDEhlbGxv', public: 'a5c367411a00ab0b542d118649de388b43ce4b7fa6dae2bb9243c6ad9aca7661'}
    callLibraryMethodSync(@client.crypto.method(:verify_signature), payload) do |response|
      expect(response.first.result['unsigned']).to eq('SGVsbG8=')
    end
  end

  it 'sha256' do
    payload = {data: encode_to_base64('hello')}
    callLibraryMethodSync(@client.crypto.method(:sha256), payload) do |response|
      expect(response.first.result['hash']).to eq('2cf24dba5fb0a30e26e83b2ac5b9e29e1b161e5c1fa7425e73043362938b9824')
    end
  end

  it 'sha512' do
    payload = {data: encode_to_base64('hello')}
    callLibraryMethodSync(@client.crypto.method(:sha512), payload) do |response|
      expect(response.first.result['hash']).to eq('9b71d224bd62f3785d96d46ad3ea3d73319bfbc2890caadae2dff72519673ca72323c3d99ba5c11d7c7acc6e14b8c5da0c4663475c2e5c3adef46f73bcdec043')
    end
  end

  it 'scrypt' do
    payload = {
        password: encode_to_base64('Test Password'),
        salt: encode_to_base64('Test Salt'),
        log_n: 5,
        r: 4,
        p: 8,
        dk_len: 32
    }
    callLibraryMethodSync(@client.crypto.method(:scrypt), payload) do |response|
      expect(response.first.result['key']).to eq('7cc741fa9cb4eb1edd36629e224e9cc8c316810ac540e4eb9ba578ff1643a3b9')
    end
  end

  it 'nacl_sign_keypair_from_secret_key' do
    payload = {secret: '254c097277e9dd09d16152ee85abde4be54030db9930e38bf7069e4684ac10bb'}
    callLibraryMethodSync(@client.crypto.method(:nacl_sign_keypair_from_secret_key), payload) do |response|
      expect(response.first.result['public']).to eq('a5c367411a00ab0b542d118649de388b43ce4b7fa6dae2bb9243c6ad9aca7661')
      expect(response.first.result['secret']).to eq('254c097277e9dd09d16152ee85abde4be54030db9930e38bf7069e4684ac10bba5c367411a00ab0b542d118649de388b43ce4b7fa6dae2bb9243c6ad9aca7661')
    end
  end

  it 'nacl_sign' do
    payload = {
        unsigned: encode_to_base64('Hello'),
        secret: '254c097277e9dd09d16152ee85abde4be54030db9930e38bf7069e4684ac10bba5c367411a00ab0b542d118649de388b43ce4b7fa6dae2bb9243c6ad9aca7661'
    }
    callLibraryMethodSync(@client.crypto.method(:nacl_sign), payload) do |response|
      expect(response.first.result['signed']).to eq('JvgdakMHpOdw7PKJX/IMQDygYJxt/kzEge0ebJHXx7H8eUOYMcL7sN0YBfwP/QZ0Z8XpffpyDJdwLpTErtnCDEhlbGxv')
    end
  end

  it 'nacl_sign_open' do
    payload = {
        signed: 'JvgdakMHpOdw7PKJX/IMQDygYJxt/kzEge0ebJHXx7H8eUOYMcL7sN0YBfwP/QZ0Z8XpffpyDJdwLpTErtnCDEhlbGxv',
        public: 'a5c367411a00ab0b542d118649de388b43ce4b7fa6dae2bb9243c6ad9aca7661'
    }
    callLibraryMethodSync(@client.crypto.method(:nacl_sign_open), payload) do |response|
      expect(response.first.result['unsigned']).to eq('SGVsbG8=')
    end
  end

  it 'nacl_sign_detached' do
    payload = {
        unsigned: encode_to_base64('Hello'),
        secret: '254c097277e9dd09d16152ee85abde4be54030db9930e38bf7069e4684ac10bba5c367411a00ab0b542d118649de388b43ce4b7fa6dae2bb9243c6ad9aca7661'
    }
    callLibraryMethodSync(@client.crypto.method(:nacl_sign_detached), payload) do |response|
      expect(response.first.result['signature']).to eq('26f81d6a4307a4e770ecf2895ff20c403ca0609c6dfe4cc481ed1e6c91d7c7b1fc79439831c2fbb0dd1805fc0ffd067467c5e97dfa720c97702e94c4aed9c20c')
    end
  end

  it 'nacl_box_keypair' do
    callLibraryMethodSync(@client.crypto.method(:nacl_box_keypair)) do |response|
      expect(response.first.result['public']).to be_a(String)
      expect(response.first.result['secret']).to be_a(String)
      expect(response.first.result['public'].size).to eq(64)
      expect(response.first.result['secret'].size).to eq(64)
    end
  end

  it 'nacl_box_keypair_from_secret_key' do
    payload = {
        secret: '254c097277e9dd09d16152ee85abde4be54030db9930e38bf7069e4684ac10bb'
    }
    callLibraryMethodSync(@client.crypto.method(:nacl_box_keypair_from_secret_key), payload) do |response|
      expect(response.first.result['public']).to eq('57172b0bd70f4bc65bb8a82bd0926a1a3f8f471e16fd9d8f329bec976afe3454')
      expect(response.first.result['secret']).to eq('254c097277e9dd09d16152ee85abde4be54030db9930e38bf7069e4684ac10bb')
    end
  end

  it 'nacl_box' do
    payload = {
        decrypted: encode_to_base64('Test Message'),
        nonce: 'cd7f99924bf422544046e83595dd5803f17536f5c9a11746',
        their_public: 'c4e2d9fe6a6baf8d1812b799856ef2a306291be7a7024837ad33a8530db79c6b',
        secret: 'd9b9dc5033fb416134e5d2107fdbacab5aadb297cb82dbdcd137d663bac59f7f'
    }
    callLibraryMethodSync(@client.crypto.method(:nacl_box), payload) do |response|
      expect(response.first.result['encrypted']).to eq('li4XED4kx/pjQ2qdP0eR2d/K30uN94voNADxwA==')
    end
  end

  it 'nacl_box_open' do
    payload = {
        encrypted: 'li4XED4kx/pjQ2qdP0eR2d/K30uN94voNADxwA==',
        nonce: 'cd7f99924bf422544046e83595dd5803f17536f5c9a11746',
        their_public: 'c4e2d9fe6a6baf8d1812b799856ef2a306291be7a7024837ad33a8530db79c6b',
        secret: 'd9b9dc5033fb416134e5d2107fdbacab5aadb297cb82dbdcd137d663bac59f7f'
    }
    callLibraryMethodSync(@client.crypto.method(:nacl_box_open), payload) do |response|
      expect(Base64.decode64(response.first.result['decrypted'])).to eq('Test Message')
    end
  end

  it 'nacl_secret_box' do
    payload = {
        decrypted: encode_to_base64('Test Message'),
        nonce: '2a33564717595ebe53d91a785b9e068aba625c8453a76e45',
        key: '8f68445b4e78c000fe4d6b7fc826879c1e63e3118379219a754ae66327764bd8'
    }
    callLibraryMethodSync(@client.crypto.method(:nacl_secret_box), payload) do |response|
      expect(response.first.result['encrypted']).to eq('JL7ejKWe2KXmrsns41yfXoQF0t/C1Q8RGyzQ2A==')
    end
  end

  it 'nacl_secret_box_open' do
    payload = {
        encrypted: 'JL7ejKWe2KXmrsns41yfXoQF0t/C1Q8RGyzQ2A==',
        nonce: '2a33564717595ebe53d91a785b9e068aba625c8453a76e45',
        key: '8f68445b4e78c000fe4d6b7fc826879c1e63e3118379219a754ae66327764bd8'
    }
    callLibraryMethodSync(@client.crypto.method(:nacl_secret_box_open), payload) do |response|
      expect(Base64.decode64(response.first.result['decrypted'])).to eq('Test Message')
    end
  end

  it 'mnemonic_words' do
    callLibraryMethodSync(@client.crypto.method(:mnemonic_words)) do |response|
      expect(response.first.result['words'].split(' ').size).to eq(2048)
    end
  end

  it 'mnemonic_from_random' do
    payload = {
        dictionary: 1, # English
        word_count: 12
    }
    callLibraryMethodSync(@client.crypto.method(:mnemonic_from_random), payload) do |response|
      expect(response.first.result['phrase'].split(' ').size).to eq(12)
    end
  end

  it 'mnemonic_from_entropy' do
    payload = {
        entropy: '00112233445566778899AABBCCDDEEFF',
        dictionary: 1, # English
        word_count: 12
    }
    callLibraryMethodSync(@client.crypto.method(:mnemonic_from_entropy), payload) do |response|
      expect(response.first.result['phrase'].split(' ').size).to eq(12)
    end
  end

  it 'mnemonic_verify' do
    payload = {
        phrase: 'abandon math mimic master filter design carbon crystal rookie group knife young',
        dictionary: 1,
        word_count: 12
    }
    callLibraryMethodSync(@client.crypto.method(:mnemonic_verify), payload) do |response|
      expect(response.first.result['valid']).to eq(true)
    end
  end

  it 'mnemonic_derive_sign_keys' do
    payload = {
        phrase: 'abandon math mimic master filter design carbon crystal rookie group knife young',
        dictionary: 1,
        word_count: 12
    }
    callLibraryMethodSync(@client.crypto.method(:mnemonic_derive_sign_keys), payload) do |response|
      expect(response.first.result['public']).to eq('61c3c5b97a33c9c0a03af112fbb27e3f44d99e1f804853f9842bb7a6e5de3ff9')
      expect(response.first.result['secret']).to eq('832410564fbe7b1301cf48dc83cbb8a3008d3cf29e05b7457086d4de041030ea')
    end
  end

  it 'hdkey_xprv_from_mnemonic' do
    payload = {
        phrase: 'abandon math mimic master filter design carbon crystal rookie group knife young'
    }
    callLibraryMethodSync(@client.crypto.method(:hdkey_xprv_from_mnemonic), payload) do |response|
      expect(response.first.result['xprv']).to eq('xprv9s21ZrQH143K3M3Auzg5wmEcKzsVbpE9PdPam5QVjW76rZ59Cw8oTg2kEqFJkNx917D8opVbuuz2jTCUtfrB7oEHU99zmnGDtPggrXNSQHB')
    end
  end

  it 'hdkey_derive_from_xprv_path' do
    payload = {
        xprv: 'xprv9s21ZrQH143K3M3Auzg5wmEcKzsVbpE9PdPam5QVjW76rZ59Cw8oTg2kEqFJkNx917D8opVbuuz2jTCUtfrB7oEHU99zmnGDtPggrXNSQHB',
        path: "m/44'/396'/0'/0/0"
    }
    callLibraryMethodSync(@client.crypto.method(:hdkey_derive_from_xprv_path), payload) do |response|
      expect(response.first.result['xprv']).to eq('xprvA3SdNsXH8HLYpps7fxXtHBSeNfGUH59ReuhXbtCx9VJUFAWaqjpuwV91xu5LFQoHgAt3KNQ8wotGq6W4P2eXaS2VVaN1xPwWzAxYnRcDBPr')
    end
  end

  it 'hdkey_secret_from_xprv' do
    payload = {
        xprv: 'xprv9s21ZrQH143K3M3Auzg5wmEcKzsVbpE9PdPam5QVjW76rZ59Cw8oTg2kEqFJkNx917D8opVbuuz2jTCUtfrB7oEHU99zmnGDtPggrXNSQHB'
    }
    callLibraryMethodSync(@client.crypto.method(:hdkey_secret_from_xprv), payload) do |response|
      expect(response.first.result['secret']).to eq('1d2037d1adbd40ccf99d44e7073a9d8e32e5675ee053a2fd1c078ef9e05a807d')
    end
  end

  it 'hdkey_public_from_xprv' do
    payload = {
        xprv: 'xprv9s21ZrQH143K3M3Auzg5wmEcKzsVbpE9PdPam5QVjW76rZ59Cw8oTg2kEqFJkNx917D8opVbuuz2jTCUtfrB7oEHU99zmnGDtPggrXNSQHB'
    }
    callLibraryMethodSync(@client.crypto.method(:hdkey_public_from_xprv), payload) do |response|
      expect(response.first.result['public']).to eq('01709823c5ada7fdede9b6a0f7f388eda0c29a54ead5ae90ede3b5baaeb242e3')
    end
  end
end


