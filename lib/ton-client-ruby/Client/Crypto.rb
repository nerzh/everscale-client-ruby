module TonClient

  class Crypto
    include CommonInstanceHelpers

    attr_reader :core, :context
    MODULE = self.to_s.downcase.gsub(/^(.+::|)(\w+)$/, '\2').freeze

    def initialize(context: Context.new, core: TonClient::TonBinding)
      @context = context
      @core = core
    end

    # INPUT: ParamsOfFactorize
    # composite: String -     # Hexadecimal representation of u64 composite number.
    # RESPONSE: ResultOfFactorize
    # factors: Array -     # Two factors of composite or empty if composite can't be factorized.
    def factorize(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfModularPower
    # base: String -     # `base` argument of calculation.
    # exponent: String -     # `exponent` argument of calculation.
    # modulus: String -     # `modulus` argument of calculation.
    # RESPONSE: ResultOfModularPower
    # modular_power: String -     # Result of modular exponentiation
    def modular_power(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfTonCrc16
    # data: String -     # Input data for CRC calculation.    # Encoded with `base64`.
    # RESPONSE: ResultOfTonCrc16
    # crc: Number -     # Calculated CRC for input data.
    def ton_crc16(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfGenerateRandomBytes
    # length: Number -     # Size of random byte array.
    # RESPONSE: ResultOfGenerateRandomBytes
    # bytes: String -     # Generated bytes encoded in `base64`.
    def generate_random_bytes(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfConvertPublicKeyToTonSafeFormat
    # public_key: String -     # Public key - 64 symbols hex string
    # RESPONSE: ResultOfConvertPublicKeyToTonSafeFormat
    # ton_public_key: String -     # Public key represented in TON safe format.
    def convert_public_key_to_ton_safe_format(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # RESPONSE: KeyPair
    # public: String -     # Public key - 64 symbols hex string
    # secret: String -     # Private key - u64 symbols hex string
    def generate_random_sign_keys(&block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: {}, &block)
    end

    # INPUT: ParamsOfSign
    # unsigned: String -     # Data that must be signed encoded in `base64`.
    # keys: KeyPair -     # Sign keys.
    # RESPONSE: ResultOfSign
    # signed: String -     # Signed data combined with signature encoded in `base64`.
    # signature: String -     # Signature encoded in `hex`.
    def sign(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfVerifySignature
    # signed: String -     # Signed data that must be verified encoded in `base64`.
    # public: String -     # Signer's public key - 64 symbols hex string
    # RESPONSE: ResultOfVerifySignature
    # unsigned: String -     # Unsigned data encoded in `base64`.
    def verify_signature(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfHash
    # data: String -     # Input data for hash calculation.    # Encoded with `base64`.
    # RESPONSE: ResultOfHash
    # hash: String -     # Hash of input `data`.    # Encoded with 'hex'.
    def sha256(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfHash
    # data: String -     # Input data for hash calculation.    # Encoded with `base64`.
    # RESPONSE: ResultOfHash
    # hash: String -     # Hash of input `data`.    # Encoded with 'hex'.
    def sha512(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfScrypt
    # password: String -     # The password bytes to be hashed. Must be encoded with `base64`.
    # salt: String -     # Salt bytes that modify the hash to protect against Rainbow table attacks. Must be encoded with `base64`.
    # log_n: Number -     # CPU/memory cost parameter
    # r: Number -     # The block size parameter, which fine-tunes sequential memory read size and performance.
    # p: Number -     # Parallelization parameter.
    # dk_len: Number -     # Intended output length in octets of the derived key.
    # RESPONSE: ResultOfScrypt
    # key: String -     # Derived key.    # Encoded with `hex`.
    def scrypt(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfNaclSignKeyPairFromSecret
    # secret: String -     # Secret key - unprefixed 0-padded to 64 symbols hex string
    # RESPONSE: KeyPair
    # public: String -     # Public key - 64 symbols hex string
    # secret: String -     # Private key - u64 symbols hex string
    def nacl_sign_keypair_from_secret_key(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfNaclSign
    # unsigned: String -     # Data that must be signed encoded in `base64`.
    # secret: String -     # Signer's secret key - unprefixed 0-padded to 64 symbols hex string
    # RESPONSE: ResultOfNaclSign
    # signed: String -     # Signed data, encoded in `base64`.
    def nacl_sign(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfNaclSignOpen
    # signed: String -     # Signed data that must be unsigned.    # Encoded with `base64`.
    # public: String -     # Signer's public key - unprefixed 0-padded to 64 symbols hex string
    # RESPONSE: ResultOfNaclSignOpen
    # unsigned: String -     # Unsigned data, encoded in `base64`.
    def nacl_sign_open(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfNaclSign
    # unsigned: String -     # Data that must be signed encoded in `base64`.
    # secret: String -     # Signer's secret key - unprefixed 0-padded to 64 symbols hex string
    # RESPONSE: ResultOfNaclSignDetached
    # signature: String -     # Signature encoded in `hex`.
    def nacl_sign_detached(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfNaclSignDetachedVerify
    # unsigned: String -     # Unsigned data that must be verified.    # Encoded with `base64`.
    # signature: String -     # Signature that must be verified.    # Encoded with `hex`.
    # public: String -     # Signer's public key - unprefixed 0-padded to 64 symbols hex string.
    # RESPONSE: ResultOfNaclSignDetachedVerify
    # succeeded: Boolean -     # `true` if verification succeeded or `false` if it failed
    def nacl_sign_detached_verify(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # RESPONSE: KeyPair
    # public: String -     # Public key - 64 symbols hex string
    # secret: String -     # Private key - u64 symbols hex string
    def nacl_box_keypair(&block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: {}, &block)
    end

    # INPUT: ParamsOfNaclBoxKeyPairFromSecret
    # secret: String -     # Secret key - unprefixed 0-padded to 64 symbols hex string
    # RESPONSE: KeyPair
    # public: String -     # Public key - 64 symbols hex string
    # secret: String -     # Private key - u64 symbols hex string
    def nacl_box_keypair_from_secret_key(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfNaclBox
    # decrypted: String -     # Data that must be encrypted encoded in `base64`.
    # nonce: String -     # Nonce, encoded in `hex`
    # their_public: String -     # Receiver's public key - unprefixed 0-padded to 64 symbols hex string
    # secret: String -     # Sender's private key - unprefixed 0-padded to 64 symbols hex string
    # RESPONSE: ResultOfNaclBox
    # encrypted: String -     # Encrypted data encoded in `base64`.
    def nacl_box(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfNaclBoxOpen
    # encrypted: String -     # Data that must be decrypted.    # Encoded with `base64`.
    # nonce: String - 
    # their_public: String -     # Sender's public key - unprefixed 0-padded to 64 symbols hex string
    # secret: String -     # Receiver's private key - unprefixed 0-padded to 64 symbols hex string
    # RESPONSE: ResultOfNaclBoxOpen
    # decrypted: String -     # Decrypted data encoded in `base64`.
    def nacl_box_open(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfNaclSecretBox
    # decrypted: String -     # Data that must be encrypted.    # Encoded with `base64`.
    # nonce: String -     # Nonce in `hex`
    # key: String -     # Secret key - unprefixed 0-padded to 64 symbols hex string
    # RESPONSE: ResultOfNaclBox
    # encrypted: String -     # Encrypted data encoded in `base64`.
    def nacl_secret_box(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfNaclSecretBoxOpen
    # encrypted: String -     # Data that must be decrypted.    # Encoded with `base64`.
    # nonce: String -     # Nonce in `hex`
    # key: String -     # Public key - unprefixed 0-padded to 64 symbols hex string
    # RESPONSE: ResultOfNaclBoxOpen
    # decrypted: String -     # Decrypted data encoded in `base64`.
    def nacl_secret_box_open(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfMnemonicWords
    # dictionary: TSDKMnemonicDictionary -     # Dictionary identifier
    # RESPONSE: ResultOfMnemonicWords
    # words: String -     # The list of mnemonic words
    def mnemonic_words(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfMnemonicFromRandom
    # dictionary: TSDKMnemonicDictionary -     # Dictionary identifier
    # word_count: Number<Optional> -     # Mnemonic word count
    # RESPONSE: ResultOfMnemonicFromRandom
    # phrase: String -     # String of mnemonic words
    def mnemonic_from_random(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfMnemonicFromEntropy
    # entropy: String -     # Entropy bytes.    # Hex encoded.
    # dictionary: TSDKMnemonicDictionary -     # Dictionary identifier
    # word_count: Number<Optional> -     # Mnemonic word count
    # RESPONSE: ResultOfMnemonicFromEntropy
    # phrase: String -     # Phrase
    def mnemonic_from_entropy(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfMnemonicVerify
    # phrase: String -     # Phrase
    # dictionary: TSDKMnemonicDictionary -     # Dictionary identifier
    # word_count: Number<Optional> -     # Word count
    # RESPONSE: ResultOfMnemonicVerify
    # valid: Boolean -     # Flag indicating if the mnemonic is valid or not
    def mnemonic_verify(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfMnemonicDeriveSignKeys
    # phrase: String -     # Phrase
    # path: String<Optional> -     # Derivation path, for instance "m/44'/396'/0'/0/0"
    # dictionary: TSDKMnemonicDictionary -     # Dictionary identifier
    # word_count: Number<Optional> -     # Word count
    # RESPONSE: KeyPair
    # public: String -     # Public key - 64 symbols hex string
    # secret: String -     # Private key - u64 symbols hex string
    def mnemonic_derive_sign_keys(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfHDKeyXPrvFromMnemonic
    # phrase: String -     # String with seed phrase
    # dictionary: TSDKMnemonicDictionary -     # Dictionary identifier
    # word_count: Number<Optional> -     # Mnemonic word count
    # RESPONSE: ResultOfHDKeyXPrvFromMnemonic
    # xprv: String -     # Serialized extended master private key
    def hdkey_xprv_from_mnemonic(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfHDKeyDeriveFromXPrv
    # xprv: String -     # Serialized extended private key
    # child_index: Number -     # Child index (see BIP-0032)
    # hardened: Boolean -     # Indicates the derivation of hardened/not-hardened key (see BIP-0032)
    # RESPONSE: ResultOfHDKeyDeriveFromXPrv
    # xprv: String -     # Serialized extended private key
    def hdkey_derive_from_xprv(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfHDKeyDeriveFromXPrvPath
    # xprv: String -     # Serialized extended private key
    # path: String -     # Derivation path, for instance "m/44'/396'/0'/0/0"
    # RESPONSE: ResultOfHDKeyDeriveFromXPrvPath
    # xprv: String -     # Derived serialized extended private key
    def hdkey_derive_from_xprv_path(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfHDKeySecretFromXPrv
    # xprv: String -     # Serialized extended private key
    # RESPONSE: ResultOfHDKeySecretFromXPrv
    # secret: String -     # Private key - 64 symbols hex string
    def hdkey_secret_from_xprv(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfHDKeyPublicFromXPrv
    # xprv: String -     # Serialized extended private key
    # RESPONSE: ResultOfHDKeyPublicFromXPrv
    # public: String -     # Public key - 64 symbols hex string
    def hdkey_public_from_xprv(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfChaCha20
    # data: String -     # Source data to be encrypted or decrypted.    # Must be encoded with `base64`.
    # key: String -     # 256-bit key.    # Must be encoded with `hex`.
    # nonce: String -     # 96-bit nonce.    # Must be encoded with `hex`.
    # RESPONSE: ResultOfChaCha20
    # data: String -     # Encrypted/decrypted data.    # Encoded with `base64`.
    def chacha20(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # RESPONSE: RegisteredSigningBox
    # handle: SigningBoxHandle -     # Handle of the signing box.
    def register_signing_box(&block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: {}, &block)
    end

    # INPUT: KeyPair
    # public: String -     # Public key - 64 symbols hex string
    # secret: String -     # Private key - u64 symbols hex string
    # RESPONSE: RegisteredSigningBox
    # handle: SigningBoxHandle -     # Handle of the signing box.
    def get_signing_box(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: RegisteredSigningBox
    # handle: SigningBoxHandle -     # Handle of the signing box.
    # RESPONSE: ResultOfSigningBoxGetPublicKey
    # pubkey: String -     # Public key of signing box.    # Encoded with hex
    def signing_box_get_public_key(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfSigningBoxSign
    # signing_box: SigningBoxHandle -     # Signing Box handle.
    # unsigned: String -     # Unsigned user data.    # Must be encoded with `base64`.
    # RESPONSE: ResultOfSigningBoxSign
    # signature: String -     # Data signature.    # Encoded with `hex`.
    def signing_box_sign(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: RegisteredSigningBox
    # handle: SigningBoxHandle -     # Handle of the signing box.
    def remove_signing_box(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

  end
end

