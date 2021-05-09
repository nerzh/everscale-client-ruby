module TonClient
  
  class Crypto

    include CommonInstanceHelpers
    MODULE = self.to_s.downcase.gsub(/^(.+::|)(\w+)$/, '\2').freeze

    attr_reader :context, :core

    def initialize(context: Context.new, core: TonClient::TonBinding)
      @context = context
      @core = core
    end

    def factorize(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    def modular_power(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    def ton_crc16(payload, &block)
      payload[:data] = encode_to_base64(payload[:data])
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    def generate_random_bytes(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    def convert_public_key_to_ton_safe_format(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    def generate_random_sign_keys(&block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), &block)
    end

    def sign(payload, &block)
      payload[:unsigned] = encode_to_base64(payload[:unsigned])
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    def verify_signature(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    def sha256(payload, &block)
      payload[:data] = encode_to_base64(payload[:data])
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    def sha512(payload, &block)
      payload[:data] = encode_to_base64(payload[:data])
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    def scrypt(payload, &block)
      payload[:password] = encode_to_base64(payload[:password])
      payload[:salt] = encode_to_base64(payload[:salt])
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    def nacl_sign_keypair_from_secret_key(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    def nacl_sign(payload, &block)
      payload[:unsigned] = encode_to_base64(payload[:unsigned])
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    def nacl_sign_open(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    def nacl_sign_detached(payload, &block)
      payload[:unsigned] = encode_to_base64(payload[:unsigned])
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    def nacl_sign_detached_verify(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    def nacl_box_keypair(&block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), &block)
    end

    def nacl_box_keypair_from_secret_key(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    def nacl_box(payload, &block)
      payload[:decrypted] = encode_to_base64(payload[:decrypted])
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    def nacl_box_open(payload, &block)
      payload[:encrypted] = encode_to_base64(payload[:encrypted])
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    def nacl_secret_box(payload, &block)
      payload[:decrypted] = encode_to_base64(payload[:decrypted])
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    def nacl_secret_box_open(payload, &block)
      payload[:encrypted] = encode_to_base64(payload[:encrypted])
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    def mnemonic_words(&block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), &block)
    end

    def mnemonic_from_random(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    def mnemonic_from_entropy(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    def mnemonic_verify(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    def mnemonic_derive_sign_keys(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    def hdkey_xprv_from_mnemonic(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    def hdkey_derive_from_xprv(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    def hdkey_derive_from_xprv_path(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    def hdkey_secret_from_xprv(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    def hdkey_public_from_xprv(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    def chacha20(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    def register_signing_box(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    def get_signing_box(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    def signing_box_get_public_key(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    def signing_box_sign(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    def remove_signing_box(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    private

    def base64?(value)
      value.is_a?(String) && (Base64.encode64(Base64.decode64(value)).strip == value)
    end

    def encode_to_base64(message)
      return message if base64?(message)
      Base64.encode64(message.force_encoding('UTF-8')).strip
    end

  end
end









