
# Ruby Client for Free TON SDK

[![GEM](https://img.shields.io/badge/ruby-gem-orange)](https://rubygems.org/gems/everscale-client-ruby)
[![SPM](https://img.shields.io/badge/SDK%20VERSION-1.34.2-green)](https://github.com/tonlabs/TON-SDK)

## Install

Install gem
```bash
gem install ton-client-ruby
```

Install TON-SDK
```bash
ton-client-ruby setup
# result - path to dylib file for ton-client-ruby configuration
```

### Manual build FreeTON SDK
0. Install Rust to your OS
1. git clone https://github.com/tonlabs/TON-SDK
2. cd ./TON-SDK
3. cargo update
4. cargo build --release

## Usage

```ruby
# For MAcOS
TonClient.configure { |config| config.ffi_lib(./TON-SDK/target/release/libton_client.dylib) }
# For Linux
# TonClient.configure { |config| config.ffi_lib(./TON-SDK/target/release/libton_client.so) }

client = TonClient.create(config: {network: {server_address: "net.ton.dev"}})

# All methods are asynchronous

# example: call method for Crypto module
payload = {composite: '17ED48941A08F981'}
client.crypto.factorize(payload) do |response|
  p response.result['factors']
end

# e.g. ...
```


## All Modules, methods and types

<details>
  <summary>Types</summary>


- #### MnemonicDictionary
  - case TON = 0
  - case ENGLISH = 1
  - case CHINESE_SIMPLIFIED = 2
  - case CHINESE_TRADITIONAL = 3
  - case FRENCH = 4
  - case ITALIAN = 5
  - case JAPANESE = 6
  - case KOREAN = 7
  - case SPANISH = 8


- #### ClientErrorCode
  - case NotImplemented = 1

  - case InvalidHex = 2

  - case InvalidBase64 = 3

  - case InvalidAddress = 4

  - case CallbackParamsCantBeConvertedToJson = 5

  - case WebsocketConnectError = 6

  - case WebsocketReceiveError = 7

  - case WebsocketSendError = 8

  - case HttpClientCreateError = 9

  - case HttpRequestCreateError = 10

  - case HttpRequestSendError = 11

  - case HttpRequestParseError = 12

  - case CallbackNotRegistered = 13

  - case NetModuleNotInit = 14

  - case InvalidConfig = 15

  - case CannotCreateRuntime = 16

  - case InvalidContextHandle = 17

  - case CannotSerializeResult = 18

  - case CannotSerializeError = 19

  - case CannotConvertJsValueToJson = 20

  - case CannotReceiveSpawnedResult = 21

  - case SetTimerError = 22

  - case InvalidParams = 23

  - case ContractsAddressConversionFailed = 24

  - case UnknownFunction = 25

  - case AppRequestError = 26

  - case NoSuchRequest = 27

  - case CanNotSendRequestResult = 28

  - case CanNotReceiveRequestResult = 29

  - case CanNotParseRequestResult = 30

  - case UnexpectedCallbackResponse = 31

  - case CanNotParseNumber = 32

  - case InternalError = 33

  - case InvalidHandle = 34

  - case LocalStorageError = 35

# Network protocol used to perform GraphQL queries.
- #### NetworkQueriesProtocol
   Each GraphQL query uses separate HTTP request.  - case HTTP = 

   All GraphQL queries will be served using single web socket connection.  - case WS = 


- #### AppRequestResult
  - case Error = Error

  - case Ok = Ok


- #### ClientError
  - code: Number

  - message: String

  - data: Value


- #### ClientConfig
  - network: NetworkConfig&lt;Optional&gt;

  - crypto: CryptoConfig&lt;Optional&gt;

  - abi: Value

  - boc: BocConfig&lt;Optional&gt;

  - proofs: ProofsConfig&lt;Optional&gt;

   For file based storage is a folder name where SDK will store its data. For browser based is a browser async storage key prefix. Default (recommended) value is "~/.tonclient" for native environments and ".tonclient" for web-browser.
  - local_storage_path: String&lt;Optional&gt;


- #### NetworkConfig
   **This field is deprecated, but left for backward-compatibility.** DApp Server public address.
  - server_address: String&lt;Optional&gt;

   List of DApp Server addresses.
   Any correct URL format can be specified, including IP addresses. This parameter is prevailing over `server_address`.
   Check the full list of [supported network endpoints](../ton-os-api/networks.md).
  - endpoints: Array&lt;Optional&gt;

   Deprecated.
   You must use `network.max_reconnect_timeout` that allows to specify maximum network resolving timeout.
  - network_retries_count: Number&lt;Optional&gt;

   Maximum time for sequential reconnections.
   Must be specified in milliseconds. Default is 120000 (2 min).
  - max_reconnect_timeout: Number&lt;Optional&gt;

   Deprecated
  - reconnect_timeout: Number&lt;Optional&gt;

   The number of automatic message processing retries that SDK performs in case of `Message Expired (507)` error - but only for those messages which local emulation was successful or failed with replay protection error.
   Default is 5.
  - message_retries_count: Number&lt;Optional&gt;

   Timeout that is used to process message delivery for the contracts which ABI does not include "expire" header. If the message is not delivered within the specified timeout the appropriate error occurs.
   Must be specified in milliseconds. Default is 40000 (40 sec).
  - message_processing_timeout: Number&lt;Optional&gt;

   Maximum timeout that is used for query response.
   Must be specified in milliseconds. Default is 40000 (40 sec).
  - wait_for_timeout: Number&lt;Optional&gt;

   Maximum time difference between server and client.
   If client's device time is out of sync and difference is more than the threshold then error will occur. Also an error will occur if the specified threshold is more than`message_processing_timeout/2`.
   Must be specified in milliseconds. Default is 15000 (15 sec).
  - out_of_sync_threshold: Number&lt;Optional&gt;

   Maximum number of randomly chosen endpoints the library uses to broadcast a message.
   Default is 1.
  - sending_endpoint_count: Number&lt;Optional&gt;

   Frequency of sync latency detection.
   Library periodically checks the current endpoint for blockchain data syncronization latency.
   If the latency (time-lag) is less then `NetworkConfig.max_latency`then library selects another endpoint.
   Must be specified in milliseconds. Default is 60000 (1 min).
  - latency_detection_interval: Number&lt;Optional&gt;

   Maximum value for the endpoint's blockchain data syncronization latency (time-lag). Library periodically checks the current endpoint for blockchain data synchronization latency. If the latency (time-lag) is less then `NetworkConfig.max_latency` then library selects another endpoint.
   Must be specified in milliseconds. Default is 60000 (1 min).
  - max_latency: Number&lt;Optional&gt;

   Default timeout for http requests.
   Is is used when no timeout specified for the request to limit the answer waiting time. If no answer received during the timeout requests ends witherror.
   Must be specified in milliseconds. Default is 60000 (1 min).
  - query_timeout: Number&lt;Optional&gt;

   Queries protocol.
   `HTTP` or `WS`.
    Default is `HTTP`.
  - queries_protocol: NetworkQueriesProtocol&lt;Optional&gt;

   UNSTABLE.
   First REMP status awaiting timeout. If no status recieved during the timeout than fallback transaction scenario is activated.
   Must be specified in milliseconds. Default is 1000 (1 sec).
  - first_remp_status_timeout: Number&lt;Optional&gt;

   UNSTABLE.
   Subsequent REMP status awaiting timeout. If no status recieved during the timeout than fallback transaction scenario is activated.
   Must be specified in milliseconds. Default is 5000 (5 sec).
  - next_remp_status_timeout: Number&lt;Optional&gt;

   Access key to GraphQL API.
   At the moment is not used in production.
  - access_key: String&lt;Optional&gt;


- #### CryptoConfig
   Mnemonic dictionary that will be used by default in crypto functions. If not specified, 1 dictionary will be used.
  - mnemonic_dictionary: Number&lt;Optional&gt;

   Mnemonic word count that will be used by default in crypto functions. If not specified the default value will be 12.
  - mnemonic_word_count: Number&lt;Optional&gt;

   Derivation path that will be used by default in crypto functions. If not specified `m/44'/396'/0'/0/0` will be used.
  - hdkey_derivation_path: String&lt;Optional&gt;


- #### AbiConfig
   Workchain id that is used by default in DeploySet
  - workchain: Number&lt;Optional&gt;

   Message lifetime for contracts which ABI includes "expire" header. The default value is 40 sec.
  - message_expiration_timeout: Number&lt;Optional&gt;

   Factor that increases the expiration timeout for each retry The default value is 1.5
  - message_expiration_timeout_grow_factor: Number&lt;Optional&gt;


- #### BocConfig
   Maximum BOC cache size in kilobytes.
   Default is 10 MB
  - cache_max_size: Number&lt;Optional&gt;


- #### ProofsConfig
   Cache proofs in the local storage.
   Default is `true`. If this value is set to `true`, downloaded proofs and master-chain BOCs are saved into thepersistent local storage (e.g. file system for native environments or browser's IndexedDBfor the web); otherwise all the data is cached only in memory in current client's contextand will be lost after destruction of the client.
  - cache_in_local_storage: Boolean&lt;Optional&gt;


- #### BuildInfoDependency
   Dependency name.
   Usually it is a crate name.
  - name: String

   Git commit hash of the related repository.
  - git_commit: String


- #### ParamsOfAppRequest
   Request ID.
   Should be used in `resolve_app_request` call
  - app_request_id: Number

   Request describing data
  - request_data: Value


- #### AppRequestResult
  - type: AppRequestResult

   Error description
  - text: String

   Request processing result
  - result: Value


- #### ResultOfGetApiReference
  - api: Value


- #### ResultOfVersion
   Core Library version
  - version: String


- #### ResultOfBuildInfo
   Build number assigned to this build by the CI.
  - build_number: Number

   Fingerprint of the most important dependencies.
  - dependencies: Array


- #### ParamsOfResolveAppRequest
   Request ID received from SDK
  - app_request_id: Number

   Result of request processing
  - result: AppRequestResult


- #### CryptoErrorCode
  - case InvalidPublicKey = 100

  - case InvalidSecretKey = 101

  - case InvalidKey = 102

  - case InvalidFactorizeChallenge = 106

  - case InvalidBigInt = 107

  - case ScryptFailed = 108

  - case InvalidKeySize = 109

  - case NaclSecretBoxFailed = 110

  - case NaclBoxFailed = 111

  - case NaclSignFailed = 112

  - case Bip39InvalidEntropy = 113

  - case Bip39InvalidPhrase = 114

  - case Bip32InvalidKey = 115

  - case Bip32InvalidDerivePath = 116

  - case Bip39InvalidDictionary = 117

  - case Bip39InvalidWordCount = 118

  - case MnemonicGenerationFailed = 119

  - case MnemonicFromEntropyFailed = 120

  - case SigningBoxNotRegistered = 121

  - case InvalidSignature = 122

  - case EncryptionBoxNotRegistered = 123

  - case InvalidIvSize = 124

  - case UnsupportedCipherMode = 125

  - case CannotCreateCipher = 126

  - case EncryptDataError = 127

  - case DecryptDataError = 128

  - case IvRequired = 129

  - case CryptoBoxNotRegistered = 130

  - case InvalidCryptoBoxType = 131

  - case CryptoBoxSecretSerializationError = 132

  - case CryptoBoxSecretDeserializationError = 133

  - case InvalidNonceSize = 134


- #### EncryptionAlgorithm
  - case AES = AES

  - case ChaCha20 = ChaCha20

  - case NaclBox = NaclBox

  - case NaclSecretBox = NaclSecretBox


- #### CipherMode
  - case CBC = 

  - case CFB = 

  - case CTR = 

  - case ECB = 

  - case OFB = 


- #### CryptoBoxSecret
  - case RandomSeedPhrase = RandomSeedPhrase

  - case PredefinedSeedPhrase = PredefinedSeedPhrase

  - case EncryptedSecret = EncryptedSecret


- #### BoxEncryptionAlgorithm
  - case ChaCha20 = ChaCha20

  - case NaclBox = NaclBox

  - case NaclSecretBox = NaclSecretBox


- #### ParamsOfAppPasswordProvider
  - case GetPassword = GetPassword


- #### ResultOfAppPasswordProvider
  - case GetPassword = GetPassword


- #### ParamsOfAppSigningBox
  - case GetPublicKey = GetPublicKey

  - case Sign = Sign


- #### ResultOfAppSigningBox
  - case GetPublicKey = GetPublicKey

  - case Sign = Sign


- #### ParamsOfAppEncryptionBox
  - case GetInfo = GetInfo

  - case Encrypt = Encrypt

  - case Decrypt = Decrypt


- #### ResultOfAppEncryptionBox
  - case GetInfo = GetInfo

  - case Encrypt = Encrypt

  - case Decrypt = Decrypt


- #### EncryptionBoxInfo
   Derivation path, for instance "m/44'/396'/0'/0/0"
  - hdpath: String&lt;Optional&gt;

   Cryptographic algorithm, used by this encryption box
  - algorithm: String&lt;Optional&gt;

   Options, depends on algorithm and specific encryption box implementation
  - options: Value&lt;Optional&gt;

   Public information, depends on algorithm
  - public: Value&lt;Optional&gt;


- #### EncryptionAlgorithm
  - type: EncryptionAlgorithm


- #### AesParamsEB
  - mode: CipherMode

  - key: String

  - iv: String&lt;Optional&gt;


- #### AesInfo
  - mode: CipherMode

  - iv: String&lt;Optional&gt;


- #### ChaCha20ParamsEB
   256-bit key.
   Must be encoded with `hex`.
  - key: String

   96-bit nonce.
   Must be encoded with `hex`.
  - nonce: String


- #### NaclBoxParamsEB
   256-bit key.
   Must be encoded with `hex`.
  - their_public: String

   256-bit key.
   Must be encoded with `hex`.
  - secret: String

   96-bit nonce.
   Must be encoded with `hex`.
  - nonce: String


- #### NaclSecretBoxParamsEB
   Secret key - unprefixed 0-padded to 64 symbols hex string
  - key: String

   Nonce in `hex`
  - nonce: String

# Crypto Box Secret.
- #### CryptoBoxSecret
  - type: CryptoBoxSecret

  - dictionary: MnemonicDictionary

  - wordcount: Number

  - phrase: String

   It is an object, containing encrypted seed phrase or private key (now we support only seed phrase).
  - encrypted_secret: String


- #### BoxEncryptionAlgorithm
  - type: BoxEncryptionAlgorithm


- #### ChaCha20ParamsCB
   96-bit nonce.
   Must be encoded with `hex`.
  - nonce: String


- #### NaclBoxParamsCB
   256-bit key.
   Must be encoded with `hex`.
  - their_public: String

   96-bit nonce.
   Must be encoded with `hex`.
  - nonce: String


- #### NaclSecretBoxParamsCB
   Nonce in `hex`
  - nonce: String


- #### ParamsOfFactorize
   Hexadecimal representation of u64 composite number.
  - composite: String


- #### ResultOfFactorize
   Two factors of composite or empty if composite can't be factorized.
  - factors: Array


- #### ParamsOfModularPower
   `base` argument of calculation.
  - base: String

   `exponent` argument of calculation.
  - exponent: String

   `modulus` argument of calculation.
  - modulus: String


- #### ResultOfModularPower
   Result of modular exponentiation
  - modular_power: String


- #### ParamsOfTonCrc16
   Input data for CRC calculation.
   Encoded with `base64`.
  - data: String


- #### ResultOfTonCrc16
   Calculated CRC for input data.
  - crc: Number


- #### ParamsOfGenerateRandomBytes
   Size of random byte array.
  - length: Number


- #### ResultOfGenerateRandomBytes
   Generated bytes encoded in `base64`.
  - bytes: String


- #### ParamsOfConvertPublicKeyToTonSafeFormat
   Public key - 64 symbols hex string
  - public_key: String


- #### ResultOfConvertPublicKeyToTonSafeFormat
   Public key represented in TON safe format.
  - ton_public_key: String


- #### KeyPair
   Public key - 64 symbols hex string
  - public: String

   Private key - u64 symbols hex string
  - secret: String


- #### ParamsOfSign
   Data that must be signed encoded in `base64`.
  - unsigned: String

   Sign keys.
  - keys: KeyPair


- #### ResultOfSign
   Signed data combined with signature encoded in `base64`.
  - signed: String

   Signature encoded in `hex`.
  - signature: String


- #### ParamsOfVerifySignature
   Signed data that must be verified encoded in `base64`.
  - signed: String

   Signer's public key - 64 symbols hex string
  - public: String


- #### ResultOfVerifySignature
   Unsigned data encoded in `base64`.
  - unsigned: String


- #### ParamsOfHash
   Input data for hash calculation.
   Encoded with `base64`.
  - data: String


- #### ResultOfHash
   Hash of input `data`.
   Encoded with 'hex'.
  - hash: String


- #### ParamsOfScrypt
   The password bytes to be hashed. Must be encoded with `base64`.
  - password: String

   Salt bytes that modify the hash to protect against Rainbow table attacks. Must be encoded with `base64`.
  - salt: String

   CPU/memory cost parameter
  - log_n: Number

   The block size parameter, which fine-tunes sequential memory read size and performance.
  - r: Number

   Parallelization parameter.
  - p: Number

   Intended output length in octets of the derived key.
  - dk_len: Number


- #### ResultOfScrypt
   Derived key.
   Encoded with `hex`.
  - key: String


- #### ParamsOfNaclSignKeyPairFromSecret
   Secret key - unprefixed 0-padded to 64 symbols hex string
  - secret: String


- #### ParamsOfNaclSign
   Data that must be signed encoded in `base64`.
  - unsigned: String

   Signer's secret key - unprefixed 0-padded to 128 symbols hex string (concatenation of 64 symbols secret and 64 symbols public keys). See `nacl_sign_keypair_from_secret_key`.
  - secret: String


- #### ResultOfNaclSign
   Signed data, encoded in `base64`.
  - signed: String


- #### ParamsOfNaclSignOpen
   Signed data that must be unsigned.
   Encoded with `base64`.
  - signed: String

   Signer's public key - unprefixed 0-padded to 64 symbols hex string
  - public: String


- #### ResultOfNaclSignOpen
   Unsigned data, encoded in `base64`.
  - unsigned: String


- #### ResultOfNaclSignDetached
   Signature encoded in `hex`.
  - signature: String


- #### ParamsOfNaclSignDetachedVerify
   Unsigned data that must be verified.
   Encoded with `base64`.
  - unsigned: String

   Signature that must be verified.
   Encoded with `hex`.
  - signature: String

   Signer's public key - unprefixed 0-padded to 64 symbols hex string.
  - public: String


- #### ResultOfNaclSignDetachedVerify
   `true` if verification succeeded or `false` if it failed
  - succeeded: Boolean


- #### ParamsOfNaclBoxKeyPairFromSecret
   Secret key - unprefixed 0-padded to 64 symbols hex string
  - secret: String


- #### ParamsOfNaclBox
   Data that must be encrypted encoded in `base64`.
  - decrypted: String

   Nonce, encoded in `hex`
  - nonce: String

   Receiver's public key - unprefixed 0-padded to 64 symbols hex string
  - their_public: String

   Sender's private key - unprefixed 0-padded to 64 symbols hex string
  - secret: String


- #### ResultOfNaclBox
   Encrypted data encoded in `base64`.
  - encrypted: String


- #### ParamsOfNaclBoxOpen
   Data that must be decrypted.
   Encoded with `base64`.
  - encrypted: String

   Nonce
  - nonce: String

   Sender's public key - unprefixed 0-padded to 64 symbols hex string
  - their_public: String

   Receiver's private key - unprefixed 0-padded to 64 symbols hex string
  - secret: String


- #### ResultOfNaclBoxOpen
   Decrypted data encoded in `base64`.
  - decrypted: String


- #### ParamsOfNaclSecretBox
   Data that must be encrypted.
   Encoded with `base64`.
  - decrypted: String

   Nonce in `hex`
  - nonce: String

   Secret key - unprefixed 0-padded to 64 symbols hex string
  - key: String


- #### ParamsOfNaclSecretBoxOpen
   Data that must be decrypted.
   Encoded with `base64`.
  - encrypted: String

   Nonce in `hex`
  - nonce: String

   Secret key - unprefixed 0-padded to 64 symbols hex string
  - key: String


- #### ParamsOfMnemonicWords
   Dictionary identifier
  - dictionary: MnemonicDictionary


- #### ResultOfMnemonicWords
   The list of mnemonic words
  - words: String


- #### ParamsOfMnemonicFromRandom
   Dictionary identifier
  - dictionary: MnemonicDictionary

   Mnemonic word count
  - word_count: Number&lt;Optional&gt;


- #### ResultOfMnemonicFromRandom
   String of mnemonic words
  - phrase: String


- #### ParamsOfMnemonicFromEntropy
   Entropy bytes.
   Hex encoded.
  - entropy: String

   Dictionary identifier
  - dictionary: MnemonicDictionary

   Mnemonic word count
  - word_count: Number&lt;Optional&gt;


- #### ResultOfMnemonicFromEntropy
   Phrase
  - phrase: String


- #### ParamsOfMnemonicVerify
   Phrase
  - phrase: String

   Dictionary identifier
  - dictionary: MnemonicDictionary

   Word count
  - word_count: Number&lt;Optional&gt;


- #### ResultOfMnemonicVerify
   Flag indicating if the mnemonic is valid or not
  - valid: Boolean


- #### ParamsOfMnemonicDeriveSignKeys
   Phrase
  - phrase: String

   Derivation path, for instance "m/44'/396'/0'/0/0"
  - path: String&lt;Optional&gt;

   Dictionary identifier
  - dictionary: MnemonicDictionary

   Word count
  - word_count: Number&lt;Optional&gt;


- #### ParamsOfHDKeyXPrvFromMnemonic
   String with seed phrase
  - phrase: String

   Dictionary identifier
  - dictionary: MnemonicDictionary

   Mnemonic word count
  - word_count: Number&lt;Optional&gt;


- #### ResultOfHDKeyXPrvFromMnemonic
   Serialized extended master private key
  - xprv: String


- #### ParamsOfHDKeyDeriveFromXPrv
   Serialized extended private key
  - xprv: String

   Child index (see BIP-0032)
  - child_index: Number

   Indicates the derivation of hardened/not-hardened key (see BIP-0032)
  - hardened: Boolean


- #### ResultOfHDKeyDeriveFromXPrv
   Serialized extended private key
  - xprv: String


- #### ParamsOfHDKeyDeriveFromXPrvPath
   Serialized extended private key
  - xprv: String

   Derivation path, for instance "m/44'/396'/0'/0/0"
  - path: String


- #### ResultOfHDKeyDeriveFromXPrvPath
   Derived serialized extended private key
  - xprv: String


- #### ParamsOfHDKeySecretFromXPrv
   Serialized extended private key
  - xprv: String


- #### ResultOfHDKeySecretFromXPrv
   Private key - 64 symbols hex string
  - secret: String


- #### ParamsOfHDKeyPublicFromXPrv
   Serialized extended private key
  - xprv: String


- #### ResultOfHDKeyPublicFromXPrv
   Public key - 64 symbols hex string
  - public: String


- #### ParamsOfChaCha20
   Source data to be encrypted or decrypted.
   Must be encoded with `base64`.
  - data: String

   256-bit key.
   Must be encoded with `hex`.
  - key: String

   96-bit nonce.
   Must be encoded with `hex`.
  - nonce: String


- #### ResultOfChaCha20
   Encrypted/decrypted data.
   Encoded with `base64`.
  - data: String


- #### ParamsOfCreateCryptoBox
   Salt used for secret encryption. For example, a mobile device can use device ID as salt.
  - secret_encryption_salt: String

   Cryptobox secret
  - secret: CryptoBoxSecret


- #### RegisteredCryptoBox
  - handle: CryptoBoxHandle

# Interface that provides a callback that returns an encrypted password, used for cryptobox secret encryption# To secure the password while passing it from application to the library,the library generates a temporary key pair, passes the pubkeyto the passwordProvider, decrypts the received password with private key,and deletes the key pair right away.
# Application should generate a temporary nacl_box_keypairand encrypt the password with naclbox function using nacl_box_keypair.secretand encryption_public_key keys + nonce = 24-byte prefix of encryption_public_key.
- #### ParamsOfAppPasswordProvider
  - type: ParamsOfAppPasswordProvider

   Temporary library pubkey, that is used on application side for password encryption, along with application temporary private key and nonce. Used for password decryption on library side.
  - encryption_public_key: String


- #### ResultOfAppPasswordProvider
  - type: ResultOfAppPasswordProvider

   Password, encrypted and encoded to base64. Crypto box uses this password to decrypt its secret (seed phrase).
  - encrypted_password: String

   Hex encoded public key of a temporary key pair, used for password encryption on application side.
   Used together with `encryption_public_key` to decode `encrypted_password`.
  - app_encryption_pubkey: String


- #### ResultOfGetCryptoBoxInfo
   Secret (seed phrase) encrypted with salt and password.
  - encrypted_secret: String


- #### ResultOfGetCryptoBoxSeedPhrase
  - phrase: String

  - dictionary: MnemonicDictionary

  - wordcount: Number


- #### ParamsOfGetSigningBoxFromCryptoBox
   Crypto Box Handle.
  - handle: Number

   HD key derivation path.
   By default, Everscale HD path is used.
  - hdpath: String&lt;Optional&gt;

   Store derived secret for this lifetime (in ms). The timer starts after each signing box operation. Secrets will be deleted immediately after each signing box operation, if this value is not set.
  - secret_lifetime: Number&lt;Optional&gt;


- #### RegisteredSigningBox
   Handle of the signing box.
  - handle: SigningBoxHandle


- #### ParamsOfGetEncryptionBoxFromCryptoBox
   Crypto Box Handle.
  - handle: Number

   HD key derivation path.
   By default, Everscale HD path is used.
  - hdpath: String&lt;Optional&gt;

   Encryption algorithm.
  - algorithm: BoxEncryptionAlgorithm

   Store derived secret for encryption algorithm for this lifetime (in ms). The timer starts after each encryption box operation. Secrets will be deleted (overwritten with zeroes) after each encryption operation, if this value is not set.
  - secret_lifetime: Number&lt;Optional&gt;


- #### RegisteredEncryptionBox
   Handle of the encryption box.
  - handle: EncryptionBoxHandle

# Signing box callbacks.
- #### ParamsOfAppSigningBox
  - type: ParamsOfAppSigningBox

   Data to sign encoded as base64
  - unsigned: String

# Returning values from signing box callbacks.
- #### ResultOfAppSigningBox
  - type: ResultOfAppSigningBox

   Signing box public key
  - public_key: String

   Data signature encoded as hex
  - signature: String


- #### ResultOfSigningBoxGetPublicKey
   Public key of signing box.
   Encoded with hex
  - pubkey: String


- #### ParamsOfSigningBoxSign
   Signing Box handle.
  - signing_box: SigningBoxHandle

   Unsigned user data.
   Must be encoded with `base64`.
  - unsigned: String


- #### ResultOfSigningBoxSign
   Data signature.
   Encoded with `hex`.
  - signature: String

# Interface for data encryption/decryption
- #### ParamsOfAppEncryptionBox
  - type: ParamsOfAppEncryptionBox

   Data, encoded in Base64
  - data: String

# Returning values from signing box callbacks.
- #### ResultOfAppEncryptionBox
  - type: ResultOfAppEncryptionBox

  - info: EncryptionBoxInfo

   Encrypted data, encoded in Base64
  - data: String


- #### ParamsOfEncryptionBoxGetInfo
   Encryption box handle
  - encryption_box: EncryptionBoxHandle


- #### ResultOfEncryptionBoxGetInfo
   Encryption box information
  - info: EncryptionBoxInfo


- #### ParamsOfEncryptionBoxEncrypt
   Encryption box handle
  - encryption_box: EncryptionBoxHandle

   Data to be encrypted, encoded in Base64
  - data: String


- #### ResultOfEncryptionBoxEncrypt
   Encrypted data, encoded in Base64.
   Padded to cipher block size
  - data: String


- #### ParamsOfEncryptionBoxDecrypt
   Encryption box handle
  - encryption_box: EncryptionBoxHandle

   Data to be decrypted, encoded in Base64
  - data: String


- #### ResultOfEncryptionBoxDecrypt
   Decrypted data, encoded in Base64.
  - data: String


- #### ParamsOfCreateEncryptionBox
   Encryption algorithm specifier including cipher parameters (key, IV, etc)
  - algorithm: EncryptionAlgorithm


- #### AbiErrorCode
  - case RequiredAddressMissingForEncodeMessage = 301

  - case RequiredCallSetMissingForEncodeMessage = 302

  - case InvalidJson = 303

  - case InvalidMessage = 304

  - case EncodeDeployMessageFailed = 305

  - case EncodeRunMessageFailed = 306

  - case AttachSignatureFailed = 307

  - case InvalidTvcImage = 308

  - case RequiredPublicKeyMissingForFunctionHeader = 309

  - case InvalidSigner = 310

  - case InvalidAbi = 311

  - case InvalidFunctionId = 312

  - case InvalidData = 313

  - case EncodeInitialDataFailed = 314


- #### Abi
  - case Contract = Contract

  - case Json = Json

  - case Handle = Handle

  - case Serialized = Serialized


- #### Signer
  - case None = None

  - case External = External

  - case Keys = Keys

  - case SigningBox = SigningBox


- #### MessageBodyType
   Message contains the input of the ABI function.  - case Input = 

   Message contains the output of the ABI function.  - case Output = 

   Message contains the input of the imported ABI function.   Occurs when contract sends an internal message to othercontract.  - case InternalOutput = 

   Message contains the input of the ABI event.  - case Event = 


- #### StateInitSource
  - case Message = Message

  - case StateInit = StateInit

  - case Tvc = Tvc


- #### MessageSource
  - case Encoded = Encoded

  - case EncodingParams = EncodingParams


- #### Abi
  - type: Abi

  - value: AbiContract


- #### FunctionHeader
   Message expiration time in seconds. If not specified - calculated automatically from message_expiration_timeout(), try_index and message_expiration_timeout_grow_factor() (if ABI includes `expire` header).
  - expire: Number&lt;Optional&gt;

   Message creation time in milliseconds.
   If not specified, `now` is used (if ABI includes `time` header).
  - time: BigInt&lt;Optional&gt;

   Public key is used by the contract to check the signature.
   Encoded in `hex`. If not specified, method fails with exception (if ABI includes `pubkey` header)..
  - pubkey: String&lt;Optional&gt;


- #### CallSet
   Function name that is being called. Or function id encoded as string in hex (starting with 0x).
  - function_name: String

   Function header.
   If an application omits some header parameters required by thecontract's ABI, the library will set the default values forthem.
  - header: FunctionHeader&lt;Optional&gt;

   Function input parameters according to ABI.
  - input: Value


- #### DeploySet
   Content of TVC file encoded in `base64`.
  - tvc: String

   Target workchain for destination address.
   Default is `0`.
  - workchain_id: Number&lt;Optional&gt;

   List of initial values for contract's public variables.
  - initial_data: Value&lt;Optional&gt;

   Optional public key that can be provided in deploy set in order to substitute one in TVM file or provided by Signer.
   Public key resolving priority:
   1. Public key from deploy set.
   2. Public key, specified in TVM file.
   3. Public key, provided by Signer.
  - initial_pubkey: String&lt;Optional&gt;


- #### Signer
  - type: Signer

  - public_key: String

  - keys: KeyPair

  - handle: SigningBoxHandle


- #### StateInitSource
  - type: StateInitSource

  - source: MessageSource

   Code BOC.
   Encoded in `base64`.
  - code: String

   Data BOC.
   Encoded in `base64`.
  - data: String

   Library BOC.
   Encoded in `base64`.
  - library: String&lt;Optional&gt;

  - tvc: String

  - public_key: String&lt;Optional&gt;

  - init_params: StateInitParams&lt;Optional&gt;


- #### StateInitParams
  - abi: Value

  - value: Value


- #### MessageSource
  - type: MessageSource

  - message: String

  - abi: Abi&lt;Optional&gt;


- #### AbiParam
  - name: String

  - type: String

  - components: Array&lt;Optional&gt;


- #### AbiEvent
  - name: String

  - inputs: Array

  - id: String&lt;Optional&gt;


- #### AbiData
  - key: Number

  - name: String

  - type: String

  - components: Array&lt;Optional&gt;


- #### AbiFunction
  - name: String

  - inputs: Array

  - outputs: Array

  - id: String&lt;Optional&gt;


- #### AbiContract
  - abi_version: Number&lt;Optional&gt;

  - version: String&lt;Optional&gt;

  - header: Array&lt;Optional&gt;

  - functions: Array&lt;Optional&gt;

  - events: Array&lt;Optional&gt;

  - data: Array&lt;Optional&gt;

  - fields: Array&lt;Optional&gt;


- #### ParamsOfEncodeMessageBody
   Contract ABI.
  - abi: Value

   Function call parameters.
   Must be specified in non deploy message.
        In case of deploy message contains parameters of constructor.
  - call_set: CallSet

   True if internal message body must be encoded.
  - is_internal: Boolean

   Signing parameters.
  - signer: Signer

   Processing try index.
   Used in message processing with retries.
        Encoder uses the provided try index to calculate messageexpiration time.
        Expiration timeouts will grow with every retry.
        Default value is 0.
  - processing_try_index: Number&lt;Optional&gt;


- #### ResultOfEncodeMessageBody
   Message body BOC encoded with `base64`.
  - body: String

   Optional data to sign.
   Encoded with `base64`.
         Presents when `message` is unsigned. Can be used for externalmessage signing. Is this case you need to sing this data andproduce signed message using `abi.attach_signature`.
  - data_to_sign: String&lt;Optional&gt;


- #### ParamsOfAttachSignatureToMessageBody
   Contract ABI
  - abi: Value

   Public key.
   Must be encoded with `hex`.
  - public_key: String

   Unsigned message body BOC.
   Must be encoded with `base64`.
  - message: String

   Signature.
   Must be encoded with `hex`.
  - signature: String


- #### ResultOfAttachSignatureToMessageBody
  - body: String


- #### ParamsOfEncodeMessage
   Contract ABI.
  - abi: Value

   Target address the message will be sent to.
   Must be specified in case of non-deploy message.
  - address: String&lt;Optional&gt;

   Deploy parameters.
   Must be specified in case of deploy message.
  - deploy_set: DeploySet&lt;Optional&gt;

   Function call parameters.
   Must be specified in case of non-deploy message.
        In case of deploy message it is optional and contains parametersof the functions that will to be called upon deploy transaction.
  - call_set: CallSet&lt;Optional&gt;

   Signing parameters.
  - signer: Signer

   Processing try index.
   Used in message processing with retries (if contract's ABI includes "expire" header).
        Encoder uses the provided try index to calculate messageexpiration time. The 1st message expiration time is specified inClient config.
        Expiration timeouts will grow with every retry.
        Retry grow factor is set in Client config:
        <.....add config parameter with default value here>Default value is 0.
  - processing_try_index: Number&lt;Optional&gt;


- #### ResultOfEncodeMessage
   Message BOC encoded with `base64`.
  - message: String

   Optional data to be signed encoded in `base64`.
   Returned in case of `Signer::External`. Can be used for externalmessage signing. Is this case you need to use this data to create signature andthen produce signed message using `abi.attach_signature`.
  - data_to_sign: String&lt;Optional&gt;

   Destination address.
  - address: String

   Message id.
  - message_id: String


- #### ParamsOfEncodeInternalMessage
   Contract ABI.
   Can be None if both deploy_set and call_set are None.
  - abi: Value&lt;Optional&gt;

   Target address the message will be sent to.
   Must be specified in case of non-deploy message.
  - address: String&lt;Optional&gt;

   Source address of the message.
  - src_address: String&lt;Optional&gt;

   Deploy parameters.
   Must be specified in case of deploy message.
  - deploy_set: DeploySet&lt;Optional&gt;

   Function call parameters.
   Must be specified in case of non-deploy message.
        In case of deploy message it is optional and contains parametersof the functions that will to be called upon deploy transaction.
  - call_set: CallSet&lt;Optional&gt;

   Value in nanotokens to be sent with message.
  - value: String

   Flag of bounceable message.
   Default is true.
  - bounce: Boolean&lt;Optional&gt;

   Enable Instant Hypercube Routing for the message.
   Default is false.
  - enable_ihr: Boolean&lt;Optional&gt;


- #### ResultOfEncodeInternalMessage
   Message BOC encoded with `base64`.
  - message: String

   Destination address.
  - address: String

   Message id.
  - message_id: String


- #### ParamsOfAttachSignature
   Contract ABI
  - abi: Value

   Public key encoded in `hex`.
  - public_key: String

   Unsigned message BOC encoded in `base64`.
  - message: String

   Signature encoded in `hex`.
  - signature: String


- #### ResultOfAttachSignature
   Signed message BOC
  - message: String

   Message ID
  - message_id: String


- #### ParamsOfDecodeMessage
   contract ABI
  - abi: Value

   Message BOC
  - message: String

   Flag allowing partial BOC decoding when ABI doesn't describe the full body BOC. Controls decoder behaviour when after decoding all described in ABI params there are some data left in BOC: `true` - return decoded values `false` - return error of incomplete BOC deserialization (default)
  - allow_partial: Boolean&lt;Optional&gt;


- #### DecodedMessageBody
   Type of the message body content.
  - body_type: MessageBodyType

   Function or event name.
  - name: String

   Parameters or result value.
  - value: Value&lt;Optional&gt;

   Function header.
  - header: FunctionHeader&lt;Optional&gt;


- #### ParamsOfDecodeMessageBody
   Contract ABI used to decode.
  - abi: Value

   Message body BOC encoded in `base64`.
  - body: String

   True if the body belongs to the internal message.
  - is_internal: Boolean

   Flag allowing partial BOC decoding when ABI doesn't describe the full body BOC. Controls decoder behaviour when after decoding all described in ABI params there are some data left in BOC: `true` - return decoded values `false` - return error of incomplete BOC deserialization (default)
  - allow_partial: Boolean&lt;Optional&gt;


- #### ParamsOfEncodeAccount
   Source of the account state init.
  - state_init: StateInitSource

   Initial balance.
  - balance: BigInt&lt;Optional&gt;

   Initial value for the `last_trans_lt`.
  - last_trans_lt: BigInt&lt;Optional&gt;

   Initial value for the `last_paid`.
  - last_paid: Number&lt;Optional&gt;

   Cache type to put the result.
   The BOC itself returned if no cache type provided
  - boc_cache: BocCacheType&lt;Optional&gt;


- #### ResultOfEncodeAccount
   Account BOC encoded in `base64`.
  - account: String

   Account ID  encoded in `hex`.
  - id: String


- #### ParamsOfDecodeAccountData
   Contract ABI
  - abi: Value

   Data BOC or BOC handle
  - data: String

   Flag allowing partial BOC decoding when ABI doesn't describe the full body BOC. Controls decoder behaviour when after decoding all described in ABI params there are some data left in BOC: `true` - return decoded values `false` - return error of incomplete BOC deserialization (default)
  - allow_partial: Boolean&lt;Optional&gt;


- #### ResultOfDecodeAccountData
   Decoded data as a JSON structure.
  - data: Value


- #### ParamsOfUpdateInitialData
   Contract ABI
  - abi: Value&lt;Optional&gt;

   Data BOC or BOC handle
  - data: String

   List of initial values for contract's static variables.
   `abi` parameter should be provided to set initial data
  - initial_data: Value

   Initial account owner's public key to set into account data
  - initial_pubkey: String&lt;Optional&gt;

   Cache type to put the result. The BOC itself returned if no cache type provided.
  - boc_cache: BocCacheType&lt;Optional&gt;


- #### ResultOfUpdateInitialData
   Updated data BOC or BOC handle
  - data: String


- #### ParamsOfEncodeInitialData
   Contract ABI
  - abi: Value&lt;Optional&gt;

   List of initial values for contract's static variables.
   `abi` parameter should be provided to set initial data
  - initial_data: Value

   Initial account owner's public key to set into account data
  - initial_pubkey: String&lt;Optional&gt;

   Cache type to put the result. The BOC itself returned if no cache type provided.
  - boc_cache: BocCacheType&lt;Optional&gt;


- #### ResultOfEncodeInitialData
   Updated data BOC or BOC handle
  - data: String


- #### ParamsOfDecodeInitialData
   Contract ABI.
   Initial data is decoded if this parameter is provided
  - abi: Value&lt;Optional&gt;

   Data BOC or BOC handle
  - data: String

   Flag allowing partial BOC decoding when ABI doesn't describe the full body BOC. Controls decoder behaviour when after decoding all described in ABI params there are some data left in BOC: `true` - return decoded values `false` - return error of incomplete BOC deserialization (default)
  - allow_partial: Boolean&lt;Optional&gt;


- #### ResultOfDecodeInitialData
   List of initial values of contract's public variables.
   Initial data is decoded if `abi` input parameter is provided
  - initial_data: Value&lt;Optional&gt;

   Initial account owner's public key
  - initial_pubkey: String


- #### ParamsOfDecodeBoc
   Parameters to decode from BOC
  - params: Array

   Data BOC or BOC handle
  - boc: String

  - allow_partial: Boolean


- #### ResultOfDecodeBoc
   Decoded data as a JSON structure.
  - data: Value


- #### ParamsOfAbiEncodeBoc
   Parameters to encode into BOC
  - params: Array

   Parameters and values as a JSON structure
  - data: Value

   Cache type to put the result.
   The BOC itself returned if no cache type provided
  - boc_cache: BocCacheType&lt;Optional&gt;


- #### ResultOfAbiEncodeBoc
   BOC encoded as base64
  - boc: String


- #### BocCacheType
  - case Pinned = Pinned

  - case Unpinned = Unpinned


- #### BocErrorCode
  - case InvalidBoc = 201

  - case SerializationError = 202

  - case InappropriateBlock = 203

  - case MissingSourceBoc = 204

  - case InsufficientCacheSize = 205

  - case BocRefNotFound = 206

  - case InvalidBocRef = 207


- #### BuilderOp
  - case Integer = Integer

  - case BitString = BitString

  - case Cell = Cell

  - case CellBoc = CellBoc

  - case Address = Address


- #### BocCacheType
  - type: BocCacheType

  - pin: String


- #### ParamsOfParse
   BOC encoded as base64
  - boc: String


- #### ResultOfParse
   JSON containing parsed BOC
  - parsed: Value


- #### ParamsOfParseShardstate
   BOC encoded as base64
  - boc: String

   Shardstate identificator
  - id: String

   Workchain shardstate belongs to
  - workchain_id: Number


- #### ParamsOfGetBlockchainConfig
   Key block BOC or zerostate BOC encoded as base64
  - block_boc: String


- #### ResultOfGetBlockchainConfig
   Blockchain config BOC encoded as base64
  - config_boc: String


- #### ParamsOfGetBocHash
   BOC encoded as base64 or BOC handle
  - boc: String


- #### ResultOfGetBocHash
   BOC root hash encoded with hex
  - hash: String


- #### ParamsOfGetBocDepth
   BOC encoded as base64 or BOC handle
  - boc: String


- #### ResultOfGetBocDepth
   BOC root cell depth
  - depth: Number


- #### ParamsOfGetCodeFromTvc
   Contract TVC image or image BOC handle
  - tvc: String


- #### ResultOfGetCodeFromTvc
   Contract code encoded as base64
  - code: String


- #### ParamsOfBocCacheGet
   Reference to the cached BOC
  - boc_ref: String


- #### ResultOfBocCacheGet
   BOC encoded as base64.
  - boc: String&lt;Optional&gt;


- #### ParamsOfBocCacheSet
   BOC encoded as base64 or BOC reference
  - boc: String

   Cache type
  - cache_type: BocCacheType


- #### ResultOfBocCacheSet
   Reference to the cached BOC
  - boc_ref: String


- #### ParamsOfBocCacheUnpin
   Pinned name
  - pin: String

   Reference to the cached BOC.
   If it is provided then only referenced BOC is unpinned
  - boc_ref: String&lt;Optional&gt;

# Cell builder operation.
- #### BuilderOp
  - type: BuilderOp

   Bit size of the value.
  - size: Number

   Value: - `Number` containing integer number.
   e.g. `123`, `-123`. - Decimal string. e.g. `"123"`, `"-123"`.
   - `0x` prefixed hexadecimal string.
     e.g `0x123`, `0X123`, `-0x123`.
  - value: Value

   Nested cell builder.
  - builder: Array

   Nested cell BOC encoded with `base64` or BOC cache key.
  - boc: String

   Address in a common `workchain:account` or base64 format.
  - address: String


- #### ParamsOfEncodeBoc
   Cell builder operations.
  - builder: Array

   Cache type to put the result. The BOC itself returned if no cache type provided.
  - boc_cache: BocCacheType&lt;Optional&gt;


- #### ResultOfEncodeBoc
   Encoded cell BOC or BOC cache key.
  - boc: String


- #### ParamsOfGetCodeSalt
   Contract code BOC encoded as base64 or code BOC handle
  - code: String

   Cache type to put the result. The BOC itself returned if no cache type provided.
  - boc_cache: BocCacheType&lt;Optional&gt;


- #### ResultOfGetCodeSalt
   Contract code salt if present.
   BOC encoded as base64 or BOC handle
  - salt: String&lt;Optional&gt;


- #### ParamsOfSetCodeSalt
   Contract code BOC encoded as base64 or code BOC handle
  - code: String

   Code salt to set.
   BOC encoded as base64 or BOC handle
  - salt: String

   Cache type to put the result. The BOC itself returned if no cache type provided.
  - boc_cache: BocCacheType&lt;Optional&gt;


- #### ResultOfSetCodeSalt
   Contract code with salt set.
   BOC encoded as base64 or BOC handle
  - code: String


- #### ParamsOfDecodeTvc
   Contract TVC image BOC encoded as base64 or BOC handle
  - tvc: String

   Cache type to put the result. The BOC itself returned if no cache type provided.
  - boc_cache: BocCacheType&lt;Optional&gt;


- #### ResultOfDecodeTvc
   Contract code BOC encoded as base64 or BOC handle
  - code: String&lt;Optional&gt;

   Contract code hash
  - code_hash: String&lt;Optional&gt;

   Contract code depth
  - code_depth: Number&lt;Optional&gt;

   Contract data BOC encoded as base64 or BOC handle
  - data: String&lt;Optional&gt;

   Contract data hash
  - data_hash: String&lt;Optional&gt;

   Contract data depth
  - data_depth: Number&lt;Optional&gt;

   Contract library BOC encoded as base64 or BOC handle
  - library: String&lt;Optional&gt;

   `special.tick` field.
   Specifies the contract ability to handle tick transactions
  - tick: Boolean&lt;Optional&gt;

   `special.tock` field.
   Specifies the contract ability to handle tock transactions
  - tock: Boolean&lt;Optional&gt;

   Is present and non-zero only in instances of large smart contracts
  - split_depth: Number&lt;Optional&gt;

   Compiler version, for example 'sol 0.49.0'
  - compiler_version: String&lt;Optional&gt;


- #### ParamsOfEncodeTvc
   Contract code BOC encoded as base64 or BOC handle
  - code: String&lt;Optional&gt;

   Contract data BOC encoded as base64 or BOC handle
  - data: String&lt;Optional&gt;

   Contract library BOC encoded as base64 or BOC handle
  - library: String&lt;Optional&gt;

   `special.tick` field.
   Specifies the contract ability to handle tick transactions
  - tick: Boolean&lt;Optional&gt;

   `special.tock` field.
   Specifies the contract ability to handle tock transactions
  - tock: Boolean&lt;Optional&gt;

   Is present and non-zero only in instances of large smart contracts
  - split_depth: Number&lt;Optional&gt;

   Cache type to put the result. The BOC itself returned if no cache type provided.
  - boc_cache: BocCacheType&lt;Optional&gt;


- #### ResultOfEncodeTvc
   Contract TVC image BOC encoded as base64 or BOC handle of boc_cache parameter was specified
  - tvc: String


- #### ParamsOfEncodeExternalInMessage
   Source address.
  - src: String&lt;Optional&gt;

   Destination address.
  - dst: String

   Bag of cells with state init (used in deploy messages).
  - init: String&lt;Optional&gt;

   Bag of cells with the message body encoded as base64.
  - body: String&lt;Optional&gt;

   Cache type to put the result.
   The BOC itself returned if no cache type provided
  - boc_cache: BocCacheType&lt;Optional&gt;


- #### ResultOfEncodeExternalInMessage
   Message BOC encoded with `base64`.
  - message: String

   Message id.
  - message_id: String


- #### ParamsOfGetCompilerVersion
   Contract code BOC encoded as base64 or code BOC handle
  - code: String


- #### ResultOfGetCompilerVersion
   Compiler version, for example 'sol 0.49.0'
  - version: String&lt;Optional&gt;


- #### ProcessingErrorCode
  - case MessageAlreadyExpired = 501

  - case MessageHasNotDestinationAddress = 502

  - case CanNotBuildMessageCell = 503

  - case FetchBlockFailed = 504

  - case SendMessageFailed = 505

  - case InvalidMessageBoc = 506

  - case MessageExpired = 507

  - case TransactionWaitTimeout = 508

  - case InvalidBlockReceived = 509

  - case CanNotCheckBlockShard = 510

  - case BlockNotFound = 511

  - case InvalidData = 512

  - case ExternalSignerMustNotBeUsed = 513

  - case MessageRejected = 514

  - case InvalidRempStatus = 515

  - case NextRempStatusTimeout = 516


- #### ProcessingEvent
  - case WillFetchFirstBlock = WillFetchFirstBlock

  - case FetchFirstBlockFailed = FetchFirstBlockFailed

  - case WillSend = WillSend

  - case DidSend = DidSend

  - case SendFailed = SendFailed

  - case WillFetchNextBlock = WillFetchNextBlock

  - case FetchNextBlockFailed = FetchNextBlockFailed

  - case MessageExpired = MessageExpired

  - case RempSentToValidators = RempSentToValidators

  - case RempIncludedIntoBlock = RempIncludedIntoBlock

  - case RempIncludedIntoAcceptedBlock = RempIncludedIntoAcceptedBlock

  - case RempOther = RempOther

  - case RempError = RempError


- #### ProcessingEvent
  - type: ProcessingEvent

  - error: ClientError

  - shard_block_id: String

  - message_id: String

  - message: String

  - timestamp: BigInt

  - json: Value


- #### ResultOfProcessMessage
   Parsed transaction.
   In addition to the regular transaction fields there is a`boc` field encoded with `base64` which contains sourcetransaction BOC.
  - transaction: Value

   List of output messages' BOCs.
   Encoded as `base64`
  - out_messages: Array

   Optional decoded message bodies according to the optional `abi` parameter.
  - decoded: DecodedOutput&lt;Optional&gt;

   Transaction fees
  - fees: TransactionFees


- #### DecodedOutput
   Decoded bodies of the out messages.
   If the message can't be decoded, then `None` will be stored inthe appropriate position.
  - out_messages: Array

   Decoded body of the function output message.
  - output: Value&lt;Optional&gt;


- #### ParamsOfSendMessage
   Message BOC.
  - message: String

   Optional message ABI.
   If this parameter is specified and the message has the`expire` header then expiration time will be checked againstthe current time to prevent unnecessary sending of already expired message.
        The `message already expired` error will be returned in thiscase.
        Note, that specifying `abi` for ABI compliant contracts isstrongly recommended, so that proper processing strategy can bechosen.
  - abi: Value&lt;Optional&gt;

   Flag for requesting events sending
  - send_events: Boolean


- #### ResultOfSendMessage
   The last generated shard block of the message destination account before the message was sent.
   This block id must be used as a parameter of the`wait_for_transaction`.
  - shard_block_id: String

   The list of endpoints to which the message was sent.
   This list id must be used as a parameter of the`wait_for_transaction`.
  - sending_endpoints: Array


- #### ParamsOfWaitForTransaction
   Optional ABI for decoding the transaction result.
   If it is specified, then the output messages' bodies will bedecoded according to this ABI.
        The `abi_decoded` result field will be filled out.
  - abi: Value&lt;Optional&gt;

   Message BOC.
   Encoded with `base64`.
  - message: String

   The last generated block id of the destination account shard before the message was sent.
   You must provide the same value as the `send_message` has returned.
  - shard_block_id: String

   Flag that enables/disables intermediate events
  - send_events: Boolean

   The list of endpoints to which the message was sent.
   Use this field to get more informative errors.
        Provide the same value as the `send_message` has returned.
        If the message was not delivered (expired), SDK will log the endpoint URLs, used for its sending.
  - sending_endpoints: Array&lt;Optional&gt;


- #### ParamsOfProcessMessage
   Message encode parameters.
  - message_encode_params: ParamsOfEncodeMessage

   Flag for requesting events sending
  - send_events: Boolean


- #### AddressStringFormat
  - case AccountId = AccountId

  - case Hex = Hex

  - case Base64 = Base64


- #### AccountAddressType
  - case AccountId = 

  - case Hex = 

  - case Base64 = 


- #### AddressStringFormat
  - type: AddressStringFormat

  - url: Boolean

  - test: Boolean

  - bounce: Boolean


- #### ParamsOfConvertAddress
   Account address in any TON format.
  - address: String

   Specify the format to convert to.
  - output_format: AddressStringFormat


- #### ResultOfConvertAddress
   Address in the specified format
  - address: String


- #### ParamsOfGetAddressType
   Account address in any TON format.
  - address: String


- #### ResultOfGetAddressType
   Account address type.
  - address_type: AccountAddressType


- #### ParamsOfCalcStorageFee
  - account: String

  - period: Number


- #### ResultOfCalcStorageFee
  - fee: String


- #### ParamsOfCompressZstd
   Uncompressed data.
   Must be encoded as base64.
  - uncompressed: String

   Compression level, from 1 to 21. Where: 1 - lowest compression level (fastest compression); 21 - highest compression level (slowest compression). If level is omitted, the default compression level is used (currently `3`).
  - level: Number&lt;Optional&gt;


- #### ResultOfCompressZstd
   Compressed data.
   Must be encoded as base64.
  - compressed: String


- #### ParamsOfDecompressZstd
   Compressed data.
   Must be encoded as base64.
  - compressed: String


- #### ResultOfDecompressZstd
   Decompressed data.
   Must be encoded as base64.
  - decompressed: String


- #### TvmErrorCode
  - case CanNotReadTransaction = 401

  - case CanNotReadBlockchainConfig = 402

  - case TransactionAborted = 403

  - case InternalError = 404

  - case ActionPhaseFailed = 405

  - case AccountCodeMissing = 406

  - case LowBalance = 407

  - case AccountFrozenOrDeleted = 408

  - case AccountMissing = 409

  - case UnknownExecutionError = 410

  - case InvalidInputStack = 411

  - case InvalidAccountBoc = 412

  - case InvalidMessageType = 413

  - case ContractExecutionError = 414


- #### AccountForExecutor
  - case None = None

  - case Uninit = Uninit

  - case Account = Account


- #### ExecutionOptions
   boc with config
  - blockchain_config: String&lt;Optional&gt;

   time that is used as transaction time
  - block_time: Number&lt;Optional&gt;

   block logical time
  - block_lt: BigInt&lt;Optional&gt;

   transaction logical time
  - transaction_lt: BigInt&lt;Optional&gt;


- #### AccountForExecutor
  - type: AccountForExecutor

   Account BOC.
   Encoded as base64.
  - boc: String

   Flag for running account with the unlimited balance.
   Can be used to calculate transaction fees without balance check
  - unlimited_balance: Boolean&lt;Optional&gt;


- #### TransactionFees
   Deprecated.
   Left for backward compatibility. Does not participate in account transaction fees calculation.
  - in_msg_fwd_fee: BigInt

   Fee for account storage
  - storage_fee: BigInt

   Fee for processing
  - gas_fee: BigInt

   Deprecated.
   Contains the same data as total_fwd_fees field. Deprecated because of its confusing name, that is not the same with GraphQL API Transaction type's field.
  - out_msgs_fwd_fee: BigInt

   Deprecated.
   This is the field that is named as `total_fees` in GraphQL API Transaction type. `total_account_fees` name is misleading, because it does not mean account fees, instead it meansvalidators total fees received for the transaction execution. It does not include some forward fees that accountactually pays now, but validators will receive later during value delivery to another account (not even in the receivingtransaction).
   Because of all of this, this field is not interesting for those who wants to understandthe real account fees, this is why it is deprecated and left for backward compatibility.
  - total_account_fees: BigInt

   Deprecated because it means total value sent in the transaction, which does not relate to any fees.
  - total_output: BigInt

   Fee for inbound external message import.
  - ext_in_msg_fee: BigInt

   Total fees the account pays for message forwarding
  - total_fwd_fees: BigInt

   Total account fees for the transaction execution. Compounds of storage_fee + gas_fee + ext_in_msg_fee + total_fwd_fees
  - account_fees: BigInt


- #### ParamsOfRunExecutor
   Input message BOC.
   Must be encoded as base64.
  - message: String

   Account to run on executor
  - account: AccountForExecutor

   Execution options.
  - execution_options: ExecutionOptions&lt;Optional&gt;

   Contract ABI for decoding output messages
  - abi: Value&lt;Optional&gt;

   Skip transaction check flag
  - skip_transaction_check: Boolean&lt;Optional&gt;

   Cache type to put the result.
   The BOC itself returned if no cache type provided
  - boc_cache: BocCacheType&lt;Optional&gt;

   Return updated account flag.
   Empty string is returned if the flag is `false`
  - return_updated_account: Boolean&lt;Optional&gt;


- #### ResultOfRunExecutor
   Parsed transaction.
   In addition to the regular transaction fields there is a`boc` field encoded with `base64` which contains sourcetransaction BOC.
  - transaction: Value

   List of output messages' BOCs.
   Encoded as `base64`
  - out_messages: Array

   Optional decoded message bodies according to the optional `abi` parameter.
  - decoded: DecodedOutput&lt;Optional&gt;

   Updated account state BOC.
   Encoded as `base64`
  - account: String

   Transaction fees
  - fees: TransactionFees


- #### ParamsOfRunTvm
   Input message BOC.
   Must be encoded as base64.
  - message: String

   Account BOC.
   Must be encoded as base64.
  - account: String

   Execution options.
  - execution_options: ExecutionOptions&lt;Optional&gt;

   Contract ABI for decoding output messages
  - abi: Value&lt;Optional&gt;

   Cache type to put the result.
   The BOC itself returned if no cache type provided
  - boc_cache: BocCacheType&lt;Optional&gt;

   Return updated account flag.
   Empty string is returned if the flag is `false`
  - return_updated_account: Boolean&lt;Optional&gt;


- #### ResultOfRunTvm
   List of output messages' BOCs.
   Encoded as `base64`
  - out_messages: Array

   Optional decoded message bodies according to the optional `abi` parameter.
  - decoded: DecodedOutput&lt;Optional&gt;

   Updated account state BOC.
   Encoded as `base64`. Attention! Only `account_state.storage.state.data` part of the BOC is updated.
  - account: String


- #### ParamsOfRunGet
   Account BOC in `base64`
  - account: String

   Function name
  - function_name: String

   Input parameters
  - input: Value

   Execution options
  - execution_options: ExecutionOptions&lt;Optional&gt;

   Convert lists based on nested tuples in the **result** into plain arrays.
   Default is `false`. Input parameters may use any of lists representationsIf you receive this error on Web: "Runtime error. Unreachable code should not be executed...",set this flag to true.
        This may happen, for example, when elector contract contains too many participants
  - tuple_list_as_array: Boolean&lt;Optional&gt;


- #### ResultOfRunGet
   Values returned by get-method on stack
  - output: Value


- #### NetErrorCode
  - case QueryFailed = 601

  - case SubscribeFailed = 602

  - case WaitForFailed = 603

  - case GetSubscriptionResultFailed = 604

  - case InvalidServerResponse = 605

  - case ClockOutOfSync = 606

  - case WaitForTimeout = 607

  - case GraphqlError = 608

  - case NetworkModuleSuspended = 609

  - case WebsocketDisconnected = 610

  - case NotSupported = 611

  - case NoEndpointsProvided = 612

  - case GraphqlWebsocketInitError = 613

  - case NetworkModuleResumed = 614


- #### SortDirection
  - case ASC = 

  - case DESC = 


- #### ParamsOfQueryOperation
  - case QueryCollection = QueryCollection

  - case WaitForCollection = WaitForCollection

  - case AggregateCollection = AggregateCollection

  - case QueryCounterparties = QueryCounterparties


- #### AggregationFn
   Returns count of filtered record  - case COUNT = 

   Returns the minimal value for a field in filtered records  - case MIN = 

   Returns the maximal value for a field in filtered records  - case MAX = 

   Returns a sum of values for a field in filtered records  - case SUM = 

   Returns an average value for a field in filtered records  - case AVERAGE = 


- #### OrderBy
  - path: String

  - direction: SortDirection


- #### ParamsOfQueryOperation
  - type: ParamsOfQueryOperation


- #### FieldAggregation
   Dot separated path to the field
  - field: String

   Aggregation function that must be applied to field values
  - fn: AggregationFn


- #### TransactionNode
   Transaction id.
  - id: String

   In message id.
  - in_msg: String

   Out message ids.
  - out_msgs: Array

   Account address.
  - account_addr: String

   Transactions total fees.
  - total_fees: String

   Aborted flag.
  - aborted: Boolean

   Compute phase exit code.
  - exit_code: Number&lt;Optional&gt;


- #### MessageNode
   Message id.
  - id: String

   Source transaction id.
   This field is missing for an external inbound messages.
  - src_transaction_id: String&lt;Optional&gt;

   Destination transaction id.
   This field is missing for an external outbound messages.
  - dst_transaction_id: String&lt;Optional&gt;

   Source address.
  - src: String&lt;Optional&gt;

   Destination address.
  - dst: String&lt;Optional&gt;

   Transferred tokens value.
  - value: String&lt;Optional&gt;

   Bounce flag.
  - bounce: Boolean

   Decoded body.
   Library tries to decode message body using provided `params.abi_registry`.
   This field will be missing if none of the provided abi can be used to decode.
  - decoded_body: DecodedMessageBody&lt;Optional&gt;


- #### ParamsOfQuery
   GraphQL query text.
  - query: String

   Variables used in query.
   Must be a map with named values that can be used in query.
  - variables: Value


- #### ResultOfQuery
   Result provided by DAppServer.
  - result: Value


- #### ParamsOfBatchQuery
   List of query operations that must be performed per single fetch.
  - operations: Array


- #### ResultOfBatchQuery
   Result values for batched queries.
   Returns an array of values. Each value corresponds to `queries` item.
  - results: Array


- #### ParamsOfQueryCollection
   Collection name (accounts, blocks, transactions, messages, block_signatures)
  - collection: String

   Collection filter
  - filter: Value

   Projection (result) string
  - result: String

   Sorting order
  - order: Array&lt;Optional&gt;

   Number of documents to return
  - limit: Number&lt;Optional&gt;


- #### ResultOfQueryCollection
   Objects that match the provided criteria
  - result: Array


- #### ParamsOfAggregateCollection
   Collection name (accounts, blocks, transactions, messages, block_signatures)
  - collection: String

   Collection filter
  - filter: Value

   Projection (result) string
  - fields: Array&lt;Optional&gt;


- #### ResultOfAggregateCollection
   Values for requested fields.
   Returns an array of strings. Each string refers to the corresponding `fields` item.
        Numeric value is returned as a decimal string representations.
  - values: Value


- #### ParamsOfWaitForCollection
   Collection name (accounts, blocks, transactions, messages, block_signatures)
  - collection: String

   Collection filter
  - filter: Value

   Projection (result) string
  - result: String

   Query timeout
  - timeout: Number&lt;Optional&gt;


- #### ResultOfWaitForCollection
   First found object that matches the provided criteria
  - result: Value


- #### ResultOfSubscribeCollection
   Subscription handle.
   Must be closed with `unsubscribe`
  - handle: Number


- #### ParamsOfSubscribeCollection
   Collection name (accounts, blocks, transactions, messages, block_signatures)
  - collection: String

   Collection filter
  - filter: Value

   Projection (result) string
  - result: String


- #### ParamsOfSubscribe
   GraphQL subscription text.
  - subscription: String

   Variables used in subscription.
   Must be a map with named values that can be used in query.
  - variables: Value


- #### ParamsOfFindLastShardBlock
   Account address
  - address: String


- #### ResultOfFindLastShardBlock
   Account shard last block ID
  - block_id: String


- #### EndpointsSet
   List of endpoints provided by server
  - endpoints: Array


- #### ResultOfGetEndpoints
   Current query endpoint
  - query: String

   List of all endpoints used by client
  - endpoints: Array


- #### ParamsOfQueryCounterparties
   Account address
  - account: String

   Projection (result) string
  - result: String

   Number of counterparties to return
  - first: Number&lt;Optional&gt;

   `cursor` field of the last received result
  - after: String&lt;Optional&gt;


- #### ParamsOfQueryTransactionTree
   Input message id.
  - in_msg: String

   List of contract ABIs that will be used to decode message bodies. Library will try to decode each returned message body using any ABI from the registry.
  - abi_registry: Array&lt;Optional&gt;

   Timeout used to limit waiting time for the missing messages and transaction.
   If some of the following messages and transactions are missing yetThe maximum waiting time is regulated by this option.
        Default value is 60000 (1 min).
  - timeout: Number&lt;Optional&gt;


- #### ResultOfQueryTransactionTree
   Messages.
  - messages: Array

   Transactions.
  - transactions: Array


- #### ParamsOfCreateBlockIterator
   Starting time to iterate from.
   If the application specifies this parameter then the iterationincludes blocks with `gen_utime` >= `start_time`.
        Otherwise the iteration starts from zero state.
        Must be specified in seconds.
  - start_time: Number&lt;Optional&gt;

   Optional end time to iterate for.
   If the application specifies this parameter then the iterationincludes blocks with `gen_utime` < `end_time`.
        Otherwise the iteration never stops.
        Must be specified in seconds.
  - end_time: Number&lt;Optional&gt;

   Shard prefix filter.
   If the application specifies this parameter and it is not the empty arraythen the iteration will include items related to accounts that belongs tothe specified shard prefixes.
        Shard prefix must be represented as a string "workchain:prefix".
        Where `workchain` is a signed integer and the `prefix` if a hexadecimalrepresentation if the 64-bit unsigned integer with tagged shard prefix.
        For example: "0:3800000000000000".
  - shard_filter: Array&lt;Optional&gt;

   Projection (result) string.
   List of the fields that must be returned for iterated items.
        This field is the same as the `result` parameter ofthe `query_collection` function.
        Note that iterated items can contains additional fields that arenot requested in the `result`.
  - result: String&lt;Optional&gt;


- #### RegisteredIterator
   Iterator handle.
   Must be removed using `remove_iterator`when it is no more needed for the application.
  - handle: Number


- #### ParamsOfResumeBlockIterator
   Iterator state from which to resume.
   Same as value returned from `iterator_next`.
  - resume_state: Value


- #### ParamsOfCreateTransactionIterator
   Starting time to iterate from.
   If the application specifies this parameter then the iterationincludes blocks with `gen_utime` >= `start_time`.
        Otherwise the iteration starts from zero state.
        Must be specified in seconds.
  - start_time: Number&lt;Optional&gt;

   Optional end time to iterate for.
   If the application specifies this parameter then the iterationincludes blocks with `gen_utime` < `end_time`.
        Otherwise the iteration never stops.
        Must be specified in seconds.
  - end_time: Number&lt;Optional&gt;

   Shard prefix filters.
   If the application specifies this parameter and it is not an empty arraythen the iteration will include items related to accounts that belongs tothe specified shard prefixes.
        Shard prefix must be represented as a string "workchain:prefix".
        Where `workchain` is a signed integer and the `prefix` if a hexadecimalrepresentation if the 64-bit unsigned integer with tagged shard prefix.
        For example: "0:3800000000000000".
        Account address conforms to the shard filter ifit belongs to the filter workchain and the first bits of address match tothe shard prefix. Only transactions with suitable account addresses are iterated.
  - shard_filter: Array&lt;Optional&gt;

   Account address filter.
   Application can specify the list of accounts for whichit wants to iterate transactions.
        If this parameter is missing or an empty list then the library iteratestransactions for all accounts that pass the shard filter.
        Note that the library doesn't detect conflicts between the account filter and the shard filterif both are specified.
        So it is an application responsibility to specify the correct filter combination.
  - accounts_filter: Array&lt;Optional&gt;

   Projection (result) string.
   List of the fields that must be returned for iterated items.
        This field is the same as the `result` parameter ofthe `query_collection` function.
        Note that iterated items can contain additional fields that arenot requested in the `result`.
  - result: String&lt;Optional&gt;

   Include `transfers` field in iterated transactions.
   If this parameter is `true` then each transaction contains field`transfers` with list of transfer. See more about this structure in function description.
  - include_transfers: Boolean&lt;Optional&gt;


- #### ParamsOfResumeTransactionIterator
   Iterator state from which to resume.
   Same as value returned from `iterator_next`.
  - resume_state: Value

   Account address filter.
   Application can specify the list of accounts for whichit wants to iterate transactions.
        If this parameter is missing or an empty list then the library iteratestransactions for all accounts that passes the shard filter.
        Note that the library doesn't detect conflicts between the account filter and the shard filterif both are specified.
        So it is the application's responsibility to specify the correct filter combination.
  - accounts_filter: Array&lt;Optional&gt;


- #### ParamsOfIteratorNext
   Iterator handle
  - iterator: Number

   Maximum count of the returned items.
   If value is missing or is less than 1 the library uses 1.
  - limit: Number&lt;Optional&gt;

   Indicates that function must return the iterator state that can be used for resuming iteration.
  - return_resume_state: Boolean&lt;Optional&gt;


- #### ResultOfIteratorNext
   Next available items.
   Note that `iterator_next` can return an empty items and `has_more` equals to `true`.
        In this case the application have to continue iteration.
        Such situation can take place when there is no data yet butthe requested `end_time` is not reached.
  - items: Array

   Indicates that there are more available items in iterated range.
  - has_more: Boolean

   Optional iterator state that can be used for resuming iteration.
   This field is returned only if the `return_resume_state` parameteris specified.
        Note that `resume_state` corresponds to the iteration positionafter the returned items.
  - resume_state: Value&lt;Optional&gt;


- #### DebotErrorCode
  - case DebotStartFailed = 801

  - case DebotFetchFailed = 802

  - case DebotExecutionFailed = 803

  - case DebotInvalidHandle = 804

  - case DebotInvalidJsonParams = 805

  - case DebotInvalidFunctionId = 806

  - case DebotInvalidAbi = 807

  - case DebotGetMethodFailed = 808

  - case DebotInvalidMsg = 809

  - case DebotExternalCallFailed = 810

  - case DebotBrowserCallbackFailed = 811

  - case DebotOperationRejected = 812

  - case DebotNoCode = 813


- #### DebotActivity
  - case Transaction = Transaction


- #### ParamsOfAppDebotBrowser
  - case Log = Log

  - case Switch = Switch

  - case SwitchCompleted = SwitchCompleted

  - case ShowAction = ShowAction

  - case Input = Input

  - case GetSigningBox = GetSigningBox

  - case InvokeDebot = InvokeDebot

  - case Send = Send

  - case Approve = Approve


- #### ResultOfAppDebotBrowser
  - case Input = Input

  - case GetSigningBox = GetSigningBox

  - case InvokeDebot = InvokeDebot

  - case Approve = Approve


- #### DebotAction
   A short action description.
   Should be used by Debot Browser as name of menu item.
  - description: String

   Depends on action type.
   Can be a debot function name or a print string (for Print Action).
  - name: String

   Action type.
  - action_type: Number

   ID of debot context to switch after action execution.
  - to: Number

   Action attributes.
   In the form of "param=value,flag". attribute example: instant, args, fargs, sign.
  - attributes: String

   Some internal action data.
   Used by debot only.
  - misc: String


- #### DebotInfo
   DeBot short name.
  - name: String&lt;Optional&gt;

   DeBot semantic version.
  - version: String&lt;Optional&gt;

   The name of DeBot deployer.
  - publisher: String&lt;Optional&gt;

   Short info about DeBot.
  - caption: String&lt;Optional&gt;

   The name of DeBot developer.
  - author: String&lt;Optional&gt;

   TON address of author for questions and donations.
  - support: String&lt;Optional&gt;

   String with the first messsage from DeBot.
  - hello: String&lt;Optional&gt;

   String with DeBot interface language (ISO-639).
  - language: String&lt;Optional&gt;

   String with DeBot ABI.
  - dabi: String&lt;Optional&gt;

   DeBot icon.
  - icon: String&lt;Optional&gt;

   Vector with IDs of DInterfaces used by DeBot.
  - interfaces: Array

   ABI version ("x.y") supported by DeBot
  - dabiVersion: String

# [UNSTABLE](UNSTABLE.md) Describes the operation that the DeBot wants to perform.
- #### DebotActivity
  - type: DebotActivity

   External inbound message BOC.
  - msg: String

   Target smart contract address.
  - dst: String

   List of spendings as a result of transaction.
  - out: Array

   Transaction total fee.
  - fee: BigInt

   Indicates if target smart contract updates its code.
  - setcode: Boolean

   Public key from keypair that was used to sign external message.
  - signkey: String

   Signing box handle used to sign external message.
  - signing_box_handle: Number


- #### Spending
   Amount of nanotokens that will be sent to `dst` address.
  - amount: BigInt

   Destination address of recipient of funds.
  - dst: String


- #### ParamsOfInit
   Debot smart contract address
  - address: String


- #### RegisteredDebot
   Debot handle which references an instance of debot engine.
  - debot_handle: DebotHandle

   Debot abi as json string.
  - debot_abi: String

   Debot metadata.
  - info: DebotInfo

# [UNSTABLE](UNSTABLE.md) Debot Browser callbacks# Called by debot engine to communicate with debot browser.
- #### ParamsOfAppDebotBrowser
  - type: ParamsOfAppDebotBrowser

   A string that must be printed to user.
  - msg: String

   Debot context ID to which debot is switched.
  - context_id: Number

   Debot action that must be shown to user as menu item. At least `description` property must be shown from [DebotAction] structure.
  - action: DebotAction

   A prompt string that must be printed to user before input request.
  - prompt: String

   Address of debot in blockchain.
  - debot_addr: String

   Internal message to DInterface address.
   Message body contains interface function and parameters.
  - message: String

   DeBot activity details.
  - activity: DebotActivity

# [UNSTABLE](UNSTABLE.md) Returning values from Debot Browser callbacks.
- #### ResultOfAppDebotBrowser
  - type: ResultOfAppDebotBrowser

   String entered by user.
  - value: String

   Signing box for signing data requested by debot engine.
   Signing box is owned and disposed by debot engine
  - signing_box: SigningBoxHandle

   Indicates whether the DeBot is allowed to perform the specified operation.
  - approved: Boolean


- #### ParamsOfStart
   Debot handle which references an instance of debot engine.
  - debot_handle: DebotHandle


- #### ParamsOfFetch
   Debot smart contract address.
  - address: String


- #### ResultOfFetch
   Debot metadata.
  - info: DebotInfo


- #### ParamsOfExecute
   Debot handle which references an instance of debot engine.
  - debot_handle: DebotHandle

   Debot Action that must be executed.
  - action: DebotAction


- #### ParamsOfSend
   Debot handle which references an instance of debot engine.
  - debot_handle: DebotHandle

   BOC of internal message to debot encoded in base64 format.
  - message: String


- #### ParamsOfRemove
   Debot handle which references an instance of debot engine.
  - debot_handle: DebotHandle


- #### ProofsErrorCode
  - case InvalidData = 901

  - case ProofCheckFailed = 902

  - case InternalError = 903

  - case DataDiffersFromProven = 904


- #### ParamsOfProofBlockData
   Single block's data, retrieved from TONOS API, that needs proof. Required fields are `id` and/or top-level `boc` (for block identification), others are optional.
  - block: Value


- #### ParamsOfProofTransactionData
   Single transaction's data as queried from DApp server, without modifications. The required fields are `id` and/or top-level `boc`, others are optional. In order to reduce network requests count, it is recommended to provide `block_id` and `boc` of transaction.
  - transaction: Value


- #### ParamsOfProofMessageData
   Single message's data as queried from DApp server, without modifications. The required fields are `id` and/or top-level `boc`, others are optional. In order to reduce network requests count, it is recommended to provide at least `boc` of message and non-null `src_transaction.id` or `dst_transaction.id`.
  - message: Value

</details>

<details>
  <summary>CLIENT</summary>

```ruby
    # Returns Core Library API reference
    def get_api_reference(&block)

    # RESPONSE: ResultOfGetApiReference
    # api: Value - 
```
```ruby
    # Returns Core Library version
    def version(&block)

    # RESPONSE: ResultOfVersion
    # version: String -     #     # Core Library version
```
```ruby
    # Returns Core Library API reference
    def config(&block)

    # RESPONSE: ClientConfig
    # network: NetworkConfig&lt;Optional&gt; - 
    # crypto: CryptoConfig&lt;Optional&gt; - 
    # abi: Value - 
    # boc: BocConfig&lt;Optional&gt; - 
    # proofs: ProofsConfig&lt;Optional&gt; - 
    # local_storage_path: String&lt;Optional&gt; -     #     # For file based storage is a folder name where SDK will store its data. For browser based is a browser async storage key prefix. Default (recommended) value is "~/.tonclient" for native environments and ".tonclient" for web-browser.
```
```ruby
    # Returns detailed information about this build.
    def build_info(&block)

    # RESPONSE: ResultOfBuildInfo
    # build_number: Number -     #     # Build number assigned to this build by the CI.
    # dependencies: Array -     #     # Fingerprint of the most important dependencies.
```
```ruby
    # Resolves application request processing result
    def resolve_app_request(payload, &block)
    # INPUT: ParamsOfResolveAppRequest
    # app_request_id: Number -     #     # Request ID received from SDK
    # result: AppRequestResult -     #     # Result of request processing
```
</details>

<details>
  <summary>CRYPTO</summary>

```ruby
    # Integer factorization    # Performs prime factorization – decomposition of a composite numberinto a product of smaller prime integers (factors).
    # See [https://en.wikipedia.org/wiki/Integer_factorization]
    def factorize(payload, &block)
    # INPUT: ParamsOfFactorize
    # composite: String -     #     # Hexadecimal representation of u64 composite number.

    # RESPONSE: ResultOfFactorize
    # factors: Array -     #     # Two factors of composite or empty if composite can't be factorized.
```
```ruby
    # Modular exponentiation    # Performs modular exponentiation for big integers (`base`^`exponent` mod `modulus`).
    # See [https://en.wikipedia.org/wiki/Modular_exponentiation]
    def modular_power(payload, &block)
    # INPUT: ParamsOfModularPower
    # base: String -     #     # `base` argument of calculation.
    # exponent: String -     #     # `exponent` argument of calculation.
    # modulus: String -     #     # `modulus` argument of calculation.

    # RESPONSE: ResultOfModularPower
    # modular_power: String -     #     # Result of modular exponentiation
```
```ruby
    # Calculates CRC16 using TON algorithm.
    def ton_crc16(payload, &block)
    # INPUT: ParamsOfTonCrc16
    # data: String -     #     # Input data for CRC calculation.    #     # Encoded with `base64`.

    # RESPONSE: ResultOfTonCrc16
    # crc: Number -     #     # Calculated CRC for input data.
```
```ruby
    # Generates random byte array of the specified length and returns it in `base64` format
    def generate_random_bytes(payload, &block)
    # INPUT: ParamsOfGenerateRandomBytes
    # length: Number -     #     # Size of random byte array.

    # RESPONSE: ResultOfGenerateRandomBytes
    # bytes: String -     #     # Generated bytes encoded in `base64`.
```
```ruby
    # Converts public key to ton safe_format
    def convert_public_key_to_ton_safe_format(payload, &block)
    # INPUT: ParamsOfConvertPublicKeyToTonSafeFormat
    # public_key: String -     #     # Public key - 64 symbols hex string

    # RESPONSE: ResultOfConvertPublicKeyToTonSafeFormat
    # ton_public_key: String -     #     # Public key represented in TON safe format.
```
```ruby
    # Generates random ed25519 key pair.
    def generate_random_sign_keys(&block)

    # RESPONSE: KeyPair
    # public: String -     #     # Public key - 64 symbols hex string
    # secret: String -     #     # Private key - u64 symbols hex string
```
```ruby
    # Signs a data using the provided keys.
    def sign(payload, &block)
    # INPUT: ParamsOfSign
    # unsigned: String -     #     # Data that must be signed encoded in `base64`.
    # keys: KeyPair -     #     # Sign keys.

    # RESPONSE: ResultOfSign
    # signed: String -     #     # Signed data combined with signature encoded in `base64`.
    # signature: String -     #     # Signature encoded in `hex`.
```
```ruby
    # Verifies signed data using the provided public key. Raises error if verification is failed.
    def verify_signature(payload, &block)
    # INPUT: ParamsOfVerifySignature
    # signed: String -     #     # Signed data that must be verified encoded in `base64`.
    # public: String -     #     # Signer's public key - 64 symbols hex string

    # RESPONSE: ResultOfVerifySignature
    # unsigned: String -     #     # Unsigned data encoded in `base64`.
```
```ruby
    # Calculates SHA256 hash of the specified data.
    def sha256(payload, &block)
    # INPUT: ParamsOfHash
    # data: String -     #     # Input data for hash calculation.    #     # Encoded with `base64`.

    # RESPONSE: ResultOfHash
    # hash: String -     #     # Hash of input `data`.    #     # Encoded with 'hex'.
```
```ruby
    # Calculates SHA512 hash of the specified data.
    def sha512(payload, &block)
    # INPUT: ParamsOfHash
    # data: String -     #     # Input data for hash calculation.    #     # Encoded with `base64`.

    # RESPONSE: ResultOfHash
    # hash: String -     #     # Hash of input `data`.    #     # Encoded with 'hex'.
```
```ruby
    # Perform `scrypt` encryption    # Derives key from `password` and `key` using `scrypt` algorithm.
    # See [https://en.wikipedia.org/wiki/Scrypt].
    # # Arguments- `log_n` - The log2 of the Scrypt parameter `N`- `r` - The Scrypt parameter `r`- `p` - The Scrypt parameter `p`# Conditions- `log_n` must be less than `64`- `r` must be greater than `0` and less than or equal to `4294967295`- `p` must be greater than `0` and less than `4294967295`# Recommended values sufficient for most use-cases- `log_n = 15` (`n = 32768`)- `r = 8`- `p = 1`
    def scrypt(payload, &block)
    # INPUT: ParamsOfScrypt
    # password: String -     #     # The password bytes to be hashed. Must be encoded with `base64`.
    # salt: String -     #     # Salt bytes that modify the hash to protect against Rainbow table attacks. Must be encoded with `base64`.
    # log_n: Number -     #     # CPU/memory cost parameter
    # r: Number -     #     # The block size parameter, which fine-tunes sequential memory read size and performance.
    # p: Number -     #     # Parallelization parameter.
    # dk_len: Number -     #     # Intended output length in octets of the derived key.

    # RESPONSE: ResultOfScrypt
    # key: String -     #     # Derived key.    #     # Encoded with `hex`.
```
```ruby
    # Generates a key pair for signing from the secret key    # **NOTE:** In the result the secret key is actually the concatenationof secret and public keys (128 symbols hex string) by design of [NaCL](http://nacl.cr.yp.to/sign.html).
    # See also [the stackexchange question](https://crypto.stackexchange.com/questions/54353/).
    def nacl_sign_keypair_from_secret_key(payload, &block)
    # INPUT: ParamsOfNaclSignKeyPairFromSecret
    # secret: String -     #     # Secret key - unprefixed 0-padded to 64 symbols hex string

    # RESPONSE: KeyPair
    # public: String -     #     # Public key - 64 symbols hex string
    # secret: String -     #     # Private key - u64 symbols hex string
```
```ruby
    # Signs data using the signer's secret key.
    def nacl_sign(payload, &block)
    # INPUT: ParamsOfNaclSign
    # unsigned: String -     #     # Data that must be signed encoded in `base64`.
    # secret: String -     #     # Signer's secret key - unprefixed 0-padded to 128 symbols hex string (concatenation of 64 symbols secret and 64 symbols public keys). See `nacl_sign_keypair_from_secret_key`.

    # RESPONSE: ResultOfNaclSign
    # signed: String -     #     # Signed data, encoded in `base64`.
```
```ruby
    # Verifies the signature and returns the unsigned message    # Verifies the signature in `signed` using the signer's public key `public`and returns the message `unsigned`.
    # If the signature fails verification, crypto_sign_open raises an exception.
    def nacl_sign_open(payload, &block)
    # INPUT: ParamsOfNaclSignOpen
    # signed: String -     #     # Signed data that must be unsigned.    #     # Encoded with `base64`.
    # public: String -     #     # Signer's public key - unprefixed 0-padded to 64 symbols hex string

    # RESPONSE: ResultOfNaclSignOpen
    # unsigned: String -     #     # Unsigned data, encoded in `base64`.
```
```ruby
    # Signs the message using the secret key and returns a signature.    # Signs the message `unsigned` using the secret key `secret`and returns a signature `signature`.
    def nacl_sign_detached(payload, &block)
    # INPUT: ParamsOfNaclSign
    # unsigned: String -     #     # Data that must be signed encoded in `base64`.
    # secret: String -     #     # Signer's secret key - unprefixed 0-padded to 128 symbols hex string (concatenation of 64 symbols secret and 64 symbols public keys). See `nacl_sign_keypair_from_secret_key`.

    # RESPONSE: ResultOfNaclSignDetached
    # signature: String -     #     # Signature encoded in `hex`.
```
```ruby
    # Verifies the signature with public key and `unsigned` data.
    def nacl_sign_detached_verify(payload, &block)
    # INPUT: ParamsOfNaclSignDetachedVerify
    # unsigned: String -     #     # Unsigned data that must be verified.    #     # Encoded with `base64`.
    # signature: String -     #     # Signature that must be verified.    #     # Encoded with `hex`.
    # public: String -     #     # Signer's public key - unprefixed 0-padded to 64 symbols hex string.

    # RESPONSE: ResultOfNaclSignDetachedVerify
    # succeeded: Boolean -     #     # `true` if verification succeeded or `false` if it failed
```
```ruby
    # Generates a random NaCl key pair
    def nacl_box_keypair(&block)

    # RESPONSE: KeyPair
    # public: String -     #     # Public key - 64 symbols hex string
    # secret: String -     #     # Private key - u64 symbols hex string
```
```ruby
    # Generates key pair from a secret key
    def nacl_box_keypair_from_secret_key(payload, &block)
    # INPUT: ParamsOfNaclBoxKeyPairFromSecret
    # secret: String -     #     # Secret key - unprefixed 0-padded to 64 symbols hex string

    # RESPONSE: KeyPair
    # public: String -     #     # Public key - 64 symbols hex string
    # secret: String -     #     # Private key - u64 symbols hex string
```
```ruby
    # Public key authenticated encryption    # Encrypt and authenticate a message using the senders secret key, the receivers publickey, and a nonce.
    def nacl_box(payload, &block)
    # INPUT: ParamsOfNaclBox
    # decrypted: String -     #     # Data that must be encrypted encoded in `base64`.
    # nonce: String -     #     # Nonce, encoded in `hex`
    # their_public: String -     #     # Receiver's public key - unprefixed 0-padded to 64 symbols hex string
    # secret: String -     #     # Sender's private key - unprefixed 0-padded to 64 symbols hex string

    # RESPONSE: ResultOfNaclBox
    # encrypted: String -     #     # Encrypted data encoded in `base64`.
```
```ruby
    # Decrypt and verify the cipher text using the receivers secret key, the senders public key, and the nonce.
    def nacl_box_open(payload, &block)
    # INPUT: ParamsOfNaclBoxOpen
    # encrypted: String -     #     # Data that must be decrypted.    #     # Encoded with `base64`.
    # nonce: String -     #     # Nonce
    # their_public: String -     #     # Sender's public key - unprefixed 0-padded to 64 symbols hex string
    # secret: String -     #     # Receiver's private key - unprefixed 0-padded to 64 symbols hex string

    # RESPONSE: ResultOfNaclBoxOpen
    # decrypted: String -     #     # Decrypted data encoded in `base64`.
```
```ruby
    # Encrypt and authenticate message using nonce and secret key.
    def nacl_secret_box(payload, &block)
    # INPUT: ParamsOfNaclSecretBox
    # decrypted: String -     #     # Data that must be encrypted.    #     # Encoded with `base64`.
    # nonce: String -     #     # Nonce in `hex`
    # key: String -     #     # Secret key - unprefixed 0-padded to 64 symbols hex string

    # RESPONSE: ResultOfNaclBox
    # encrypted: String -     #     # Encrypted data encoded in `base64`.
```
```ruby
    # Decrypts and verifies cipher text using `nonce` and secret `key`.
    def nacl_secret_box_open(payload, &block)
    # INPUT: ParamsOfNaclSecretBoxOpen
    # encrypted: String -     #     # Data that must be decrypted.    #     # Encoded with `base64`.
    # nonce: String -     #     # Nonce in `hex`
    # key: String -     #     # Secret key - unprefixed 0-padded to 64 symbols hex string

    # RESPONSE: ResultOfNaclBoxOpen
    # decrypted: String -     #     # Decrypted data encoded in `base64`.
```
```ruby
    # Prints the list of words from the specified dictionary
    def mnemonic_words(payload, &block)
    # INPUT: ParamsOfMnemonicWords
    # dictionary: MnemonicDictionary -     #     # Dictionary identifier

    # RESPONSE: ResultOfMnemonicWords
    # words: String -     #     # The list of mnemonic words
```
```ruby
    # Generates a random mnemonic    # Generates a random mnemonic from the specified dictionary and word count
    def mnemonic_from_random(payload, &block)
    # INPUT: ParamsOfMnemonicFromRandom
    # dictionary: MnemonicDictionary -     #     # Dictionary identifier
    # word_count: Number&lt;Optional&gt; -     #     # Mnemonic word count

    # RESPONSE: ResultOfMnemonicFromRandom
    # phrase: String -     #     # String of mnemonic words
```
```ruby
    # Generates mnemonic from pre-generated entropy
    def mnemonic_from_entropy(payload, &block)
    # INPUT: ParamsOfMnemonicFromEntropy
    # entropy: String -     #     # Entropy bytes.    #     # Hex encoded.
    # dictionary: MnemonicDictionary -     #     # Dictionary identifier
    # word_count: Number&lt;Optional&gt; -     #     # Mnemonic word count

    # RESPONSE: ResultOfMnemonicFromEntropy
    # phrase: String -     #     # Phrase
```
```ruby
    # Validates a mnemonic phrase    # The phrase supplied will be checked for word length and validated according to the checksumspecified in BIP0039.
    def mnemonic_verify(payload, &block)
    # INPUT: ParamsOfMnemonicVerify
    # phrase: String -     #     # Phrase
    # dictionary: MnemonicDictionary -     #     # Dictionary identifier
    # word_count: Number&lt;Optional&gt; -     #     # Word count

    # RESPONSE: ResultOfMnemonicVerify
    # valid: Boolean -     #     # Flag indicating if the mnemonic is valid or not
```
```ruby
    # Derives a key pair for signing from the seed phrase    # Validates the seed phrase, generates master key and then derivesthe key pair from the master key and the specified path
    def mnemonic_derive_sign_keys(payload, &block)
    # INPUT: ParamsOfMnemonicDeriveSignKeys
    # phrase: String -     #     # Phrase
    # path: String&lt;Optional&gt; -     #     # Derivation path, for instance "m/44'/396'/0'/0/0"
    # dictionary: MnemonicDictionary -     #     # Dictionary identifier
    # word_count: Number&lt;Optional&gt; -     #     # Word count

    # RESPONSE: KeyPair
    # public: String -     #     # Public key - 64 symbols hex string
    # secret: String -     #     # Private key - u64 symbols hex string
```
```ruby
    # Generates an extended master private key that will be the root for all the derived keys
    def hdkey_xprv_from_mnemonic(payload, &block)
    # INPUT: ParamsOfHDKeyXPrvFromMnemonic
    # phrase: String -     #     # String with seed phrase
    # dictionary: MnemonicDictionary -     #     # Dictionary identifier
    # word_count: Number&lt;Optional&gt; -     #     # Mnemonic word count

    # RESPONSE: ResultOfHDKeyXPrvFromMnemonic
    # xprv: String -     #     # Serialized extended master private key
```
```ruby
    # Returns extended private key derived from the specified extended private key and child index
    def hdkey_derive_from_xprv(payload, &block)
    # INPUT: ParamsOfHDKeyDeriveFromXPrv
    # xprv: String -     #     # Serialized extended private key
    # child_index: Number -     #     # Child index (see BIP-0032)
    # hardened: Boolean -     #     # Indicates the derivation of hardened/not-hardened key (see BIP-0032)

    # RESPONSE: ResultOfHDKeyDeriveFromXPrv
    # xprv: String -     #     # Serialized extended private key
```
```ruby
    # Derives the extended private key from the specified key and path
    def hdkey_derive_from_xprv_path(payload, &block)
    # INPUT: ParamsOfHDKeyDeriveFromXPrvPath
    # xprv: String -     #     # Serialized extended private key
    # path: String -     #     # Derivation path, for instance "m/44'/396'/0'/0/0"

    # RESPONSE: ResultOfHDKeyDeriveFromXPrvPath
    # xprv: String -     #     # Derived serialized extended private key
```
```ruby
    # Extracts the private key from the serialized extended private key
    def hdkey_secret_from_xprv(payload, &block)
    # INPUT: ParamsOfHDKeySecretFromXPrv
    # xprv: String -     #     # Serialized extended private key

    # RESPONSE: ResultOfHDKeySecretFromXPrv
    # secret: String -     #     # Private key - 64 symbols hex string
```
```ruby
    # Extracts the public key from the serialized extended private key
    def hdkey_public_from_xprv(payload, &block)
    # INPUT: ParamsOfHDKeyPublicFromXPrv
    # xprv: String -     #     # Serialized extended private key

    # RESPONSE: ResultOfHDKeyPublicFromXPrv
    # public: String -     #     # Public key - 64 symbols hex string
```
```ruby
    # Performs symmetric `chacha20` encryption.
    def chacha20(payload, &block)
    # INPUT: ParamsOfChaCha20
    # data: String -     #     # Source data to be encrypted or decrypted.    #     # Must be encoded with `base64`.
    # key: String -     #     # 256-bit key.    #     # Must be encoded with `hex`.
    # nonce: String -     #     # 96-bit nonce.    #     # Must be encoded with `hex`.

    # RESPONSE: ResultOfChaCha20
    # data: String -     #     # Encrypted/decrypted data.    #     # Encoded with `base64`.
```
```ruby
    # Creates a Crypto Box instance.    # Crypto Box is a root crypto object, that encapsulates some secret (seed phrase usually)in encrypted form and acts as a factory for all crypto primitives used in SDK:
    # keys for signing and encryption, derived from this secret.
    # Crypto Box encrypts original Seed Phrase with salt and password that is retrievedfrom `password_provider` callback, implemented on Application side.
    # When used, decrypted secret shows up in core library's memory for a very short periodof time and then is immediately overwritten with zeroes.
    def create_crypto_box(payload, &block)
    # INPUT: ParamsOfCreateCryptoBox
    # secret_encryption_salt: String -     #     # Salt used for secret encryption. For example, a mobile device can use device ID as salt.
    # secret: CryptoBoxSecret -     #     # Cryptobox secret

    # RESPONSE: RegisteredCryptoBox
    # handle: CryptoBoxHandle - 
```
```ruby
    # Removes Crypto Box. Clears all secret data.
    def remove_crypto_box(payload, &block)
    # INPUT: RegisteredCryptoBox
    # handle: CryptoBoxHandle - 
```
```ruby
    # Get Crypto Box Info. Used to get `encrypted_secret` that should be used for all the cryptobox initializations except the first one.
    def get_crypto_box_info(payload, &block)
    # INPUT: RegisteredCryptoBox
    # handle: CryptoBoxHandle - 

    # RESPONSE: ResultOfGetCryptoBoxInfo
    # encrypted_secret: String -     #     # Secret (seed phrase) encrypted with salt and password.
```
```ruby
    # Get Crypto Box Seed Phrase.    # Attention! Store this data in your application for a very short period of time and overwrite it with zeroes ASAP.
    def get_crypto_box_seed_phrase(payload, &block)
    # INPUT: RegisteredCryptoBox
    # handle: CryptoBoxHandle - 

    # RESPONSE: ResultOfGetCryptoBoxSeedPhrase
    # phrase: String - 
    # dictionary: MnemonicDictionary - 
    # wordcount: Number - 
```
```ruby
    # Get handle of Signing Box derived from Crypto Box.
    def get_signing_box_from_crypto_box(payload, &block)
    # INPUT: ParamsOfGetSigningBoxFromCryptoBox
    # handle: Number -     #     # Crypto Box Handle.
    # hdpath: String&lt;Optional&gt; -     #     # HD key derivation path.    #     # By default, Everscale HD path is used.
    # secret_lifetime: Number&lt;Optional&gt; -     #     # Store derived secret for this lifetime (in ms). The timer starts after each signing box operation. Secrets will be deleted immediately after each signing box operation, if this value is not set.

    # RESPONSE: RegisteredSigningBox
    # handle: SigningBoxHandle -     #     # Handle of the signing box.
```
```ruby
    # Gets Encryption Box from Crypto Box.    # Derives encryption keypair from cryptobox secret and hdpath andstores it in cache for `secret_lifetime`or until explicitly cleared by `clear_crypto_box_secret_cache` method.
    # If `secret_lifetime` is not specified - overwrites encryption secret with zeroes immediately afterencryption operation.
    def get_encryption_box_from_crypto_box(payload, &block)
    # INPUT: ParamsOfGetEncryptionBoxFromCryptoBox
    # handle: Number -     #     # Crypto Box Handle.
    # hdpath: String&lt;Optional&gt; -     #     # HD key derivation path.    #     # By default, Everscale HD path is used.
    # algorithm: BoxEncryptionAlgorithm -     #     # Encryption algorithm.
    # secret_lifetime: Number&lt;Optional&gt; -     #     # Store derived secret for encryption algorithm for this lifetime (in ms). The timer starts after each encryption box operation. Secrets will be deleted (overwritten with zeroes) after each encryption operation, if this value is not set.

    # RESPONSE: RegisteredEncryptionBox
    # handle: EncryptionBoxHandle -     #     # Handle of the encryption box.
```
```ruby
    # Removes cached secrets (overwrites with zeroes) from all signing and encryption boxes, derived from crypto box.
    def clear_crypto_box_secret_cache(payload, &block)
    # INPUT: RegisteredCryptoBox
    # handle: CryptoBoxHandle - 
```
```ruby
    # Register an application implemented signing box.
    def register_signing_box(&block)

    # RESPONSE: RegisteredSigningBox
    # handle: SigningBoxHandle -     #     # Handle of the signing box.
```
```ruby
    # Creates a default signing box implementation.
    def get_signing_box(payload, &block)
    # INPUT: KeyPair
    # public: String -     #     # Public key - 64 symbols hex string
    # secret: String -     #     # Private key - u64 symbols hex string

    # RESPONSE: RegisteredSigningBox
    # handle: SigningBoxHandle -     #     # Handle of the signing box.
```
```ruby
    # Returns public key of signing key pair.
    def signing_box_get_public_key(payload, &block)
    # INPUT: RegisteredSigningBox
    # handle: SigningBoxHandle -     #     # Handle of the signing box.

    # RESPONSE: ResultOfSigningBoxGetPublicKey
    # pubkey: String -     #     # Public key of signing box.    #     # Encoded with hex
```
```ruby
    # Returns signed user data.
    def signing_box_sign(payload, &block)
    # INPUT: ParamsOfSigningBoxSign
    # signing_box: SigningBoxHandle -     #     # Signing Box handle.
    # unsigned: String -     #     # Unsigned user data.    #     # Must be encoded with `base64`.

    # RESPONSE: ResultOfSigningBoxSign
    # signature: String -     #     # Data signature.    #     # Encoded with `hex`.
```
```ruby
    # Removes signing box from SDK.
    def remove_signing_box(payload, &block)
    # INPUT: RegisteredSigningBox
    # handle: SigningBoxHandle -     #     # Handle of the signing box.
```
```ruby
    # Register an application implemented encryption box.
    def register_encryption_box(&block)

    # RESPONSE: RegisteredEncryptionBox
    # handle: EncryptionBoxHandle -     #     # Handle of the encryption box.
```
```ruby
    # Removes encryption box from SDK
    def remove_encryption_box(payload, &block)
    # INPUT: RegisteredEncryptionBox
    # handle: EncryptionBoxHandle -     #     # Handle of the encryption box.
```
```ruby
    # Queries info from the given encryption box
    def encryption_box_get_info(payload, &block)
    # INPUT: ParamsOfEncryptionBoxGetInfo
    # encryption_box: EncryptionBoxHandle -     #     # Encryption box handle

    # RESPONSE: ResultOfEncryptionBoxGetInfo
    # info: EncryptionBoxInfo -     #     # Encryption box information
```
```ruby
    # Encrypts data using given encryption box Note.    # Block cipher algorithms pad data to cipher block size so encrypted data can be longer then original data. Client should store the original data size after encryption and use it afterdecryption to retrieve the original data from decrypted data.
    def encryption_box_encrypt(payload, &block)
    # INPUT: ParamsOfEncryptionBoxEncrypt
    # encryption_box: EncryptionBoxHandle -     #     # Encryption box handle
    # data: String -     #     # Data to be encrypted, encoded in Base64

    # RESPONSE: ResultOfEncryptionBoxEncrypt
    # data: String -     #     # Encrypted data, encoded in Base64.    #     # Padded to cipher block size
```
```ruby
    # Decrypts data using given encryption box Note.    # Block cipher algorithms pad data to cipher block size so encrypted data can be longer then original data. Client should store the original data size after encryption and use it afterdecryption to retrieve the original data from decrypted data.
    def encryption_box_decrypt(payload, &block)
    # INPUT: ParamsOfEncryptionBoxDecrypt
    # encryption_box: EncryptionBoxHandle -     #     # Encryption box handle
    # data: String -     #     # Data to be decrypted, encoded in Base64

    # RESPONSE: ResultOfEncryptionBoxDecrypt
    # data: String -     #     # Decrypted data, encoded in Base64.
```
```ruby
    # Creates encryption box with specified algorithm
    def create_encryption_box(payload, &block)
    # INPUT: ParamsOfCreateEncryptionBox
    # algorithm: EncryptionAlgorithm -     #     # Encryption algorithm specifier including cipher parameters (key, IV, etc)

    # RESPONSE: RegisteredEncryptionBox
    # handle: EncryptionBoxHandle -     #     # Handle of the encryption box.
```
</details>

<details>
  <summary>ABI</summary>

```ruby
    # Encodes message body according to ABI function call.
    def encode_message_body(payload, &block)
    # INPUT: ParamsOfEncodeMessageBody
    # abi: Value -     #     # Contract ABI.
    # call_set: CallSet -     #     # Function call parameters.    #     # Must be specified in non deploy message.
    #   #     # In case of deploy message contains parameters of constructor.
    # is_internal: Boolean -     #     # True if internal message body must be encoded.
    # signer: Signer -     #     # Signing parameters.
    # processing_try_index: Number&lt;Optional&gt; -     #     # Processing try index.    #     # Used in message processing with retries.
    #   #     # Encoder uses the provided try index to calculate messageexpiration time.
    #   #     # Expiration timeouts will grow with every retry.
    #   #     # Default value is 0.

    # RESPONSE: ResultOfEncodeMessageBody
    # body: String -     #     # Message body BOC encoded with `base64`.
    # data_to_sign: String&lt;Optional&gt; -     #     # Optional data to sign.    #     # Encoded with `base64`.
    #   #     # # Presents when `message` is unsigned. Can be used for externalmessage signing. Is this case you need to sing this data andproduce signed message using `abi.attach_signature`.
```
```ruby

    def attach_signature_to_message_body(payload, &block)
    # INPUT: ParamsOfAttachSignatureToMessageBody
    # abi: Value -     #     # Contract ABI
    # public_key: String -     #     # Public key.    #     # Must be encoded with `hex`.
    # message: String -     #     # Unsigned message body BOC.    #     # Must be encoded with `base64`.
    # signature: String -     #     # Signature.    #     # Must be encoded with `hex`.

    # RESPONSE: ResultOfAttachSignatureToMessageBody
    # body: String - 
```
```ruby
    # Encodes an ABI-compatible message    # Allows to encode deploy and function call messages,both signed and unsigned.
    # Use cases include messages of any possible type:
    # - deploy with initial function call (i.e. `constructor` or any other function that is used for some kindof initialization);
    # - deploy without initial function call;
    # - signed/unsigned + data for signing.
    # `Signer` defines how the message should or shouldn't be signed:
    # `Signer::None` creates an unsigned message. This may be needed in case of some public methods,that do not require authorization by pubkey.
    # `Signer::External` takes public key and returns `data_to_sign` for later signing.
    # Use `attach_signature` method with the result signature to get the signed message.
    # `Signer::Keys` creates a signed message with provided key pair.
    # [SOON] `Signer::SigningBox` Allows using a special interface to implement signingwithout private key disclosure to SDK. For instance, in case of using a cold wallet or HSM,when application calls some API to sign data.
    # There is an optional public key can be provided in deploy set in order to substitute onein TVM file.
    # Public key resolving priority:
    # 1. Public key from deploy set.
    # 2. Public key, specified in TVM file.
    # 3. Public key, provided by signer.
    def encode_message(payload, &block)
    # INPUT: ParamsOfEncodeMessage
    # abi: Value -     #     # Contract ABI.
    # address: String&lt;Optional&gt; -     #     # Target address the message will be sent to.    #     # Must be specified in case of non-deploy message.
    # deploy_set: DeploySet&lt;Optional&gt; -     #     # Deploy parameters.    #     # Must be specified in case of deploy message.
    # call_set: CallSet&lt;Optional&gt; -     #     # Function call parameters.    #     # Must be specified in case of non-deploy message.
    #   #     # In case of deploy message it is optional and contains parametersof the functions that will to be called upon deploy transaction.
    # signer: Signer -     #     # Signing parameters.
    # processing_try_index: Number&lt;Optional&gt; -     #     # Processing try index.    #     # Used in message processing with retries (if contract's ABI includes "expire" header).
    #   #     # Encoder uses the provided try index to calculate messageexpiration time. The 1st message expiration time is specified inClient config.
    #   #     # Expiration timeouts will grow with every retry.
    #   #     # Retry grow factor is set in Client config:
    #   #     # <.....add config parameter with default value here>Default value is 0.

    # RESPONSE: ResultOfEncodeMessage
    # message: String -     #     # Message BOC encoded with `base64`.
    # data_to_sign: String&lt;Optional&gt; -     #     # Optional data to be signed encoded in `base64`.    #     # Returned in case of `Signer::External`. Can be used for externalmessage signing. Is this case you need to use this data to create signature andthen produce signed message using `abi.attach_signature`.
    # address: String -     #     # Destination address.
    # message_id: String -     #     # Message id.
```
```ruby
    # Encodes an internal ABI-compatible message    # Allows to encode deploy and function call messages.
    # Use cases include messages of any possible type:
    # - deploy with initial function call (i.e. `constructor` or any other function that is used for some kindof initialization);
    # - deploy without initial function call;
    # - simple function callThere is an optional public key can be provided in deploy set in order to substitute onein TVM file.
    # Public key resolving priority:
    # 1. Public key from deploy set.
    # 2. Public key, specified in TVM file.
    def encode_internal_message(payload, &block)
    # INPUT: ParamsOfEncodeInternalMessage
    # abi: Value&lt;Optional&gt; -     #     # Contract ABI.    #     # Can be None if both deploy_set and call_set are None.
    # address: String&lt;Optional&gt; -     #     # Target address the message will be sent to.    #     # Must be specified in case of non-deploy message.
    # src_address: String&lt;Optional&gt; -     #     # Source address of the message.
    # deploy_set: DeploySet&lt;Optional&gt; -     #     # Deploy parameters.    #     # Must be specified in case of deploy message.
    # call_set: CallSet&lt;Optional&gt; -     #     # Function call parameters.    #     # Must be specified in case of non-deploy message.
    #   #     # In case of deploy message it is optional and contains parametersof the functions that will to be called upon deploy transaction.
    # value: String -     #     # Value in nanotokens to be sent with message.
    # bounce: Boolean&lt;Optional&gt; -     #     # Flag of bounceable message.    #     # Default is true.
    # enable_ihr: Boolean&lt;Optional&gt; -     #     # Enable Instant Hypercube Routing for the message.    #     # Default is false.

    # RESPONSE: ResultOfEncodeInternalMessage
    # message: String -     #     # Message BOC encoded with `base64`.
    # address: String -     #     # Destination address.
    # message_id: String -     #     # Message id.
```
```ruby
    # Combines `hex`-encoded `signature` with `base64`-encoded `unsigned_message`. Returns signed message encoded in `base64`.
    def attach_signature(payload, &block)
    # INPUT: ParamsOfAttachSignature
    # abi: Value -     #     # Contract ABI
    # public_key: String -     #     # Public key encoded in `hex`.
    # message: String -     #     # Unsigned message BOC encoded in `base64`.
    # signature: String -     #     # Signature encoded in `hex`.

    # RESPONSE: ResultOfAttachSignature
    # message: String -     #     # Signed message BOC
    # message_id: String -     #     # Message ID
```
```ruby
    # Decodes message body using provided message BOC and ABI.
    def decode_message(payload, &block)
    # INPUT: ParamsOfDecodeMessage
    # abi: Value -     #     # contract ABI
    # message: String -     #     # Message BOC
    # allow_partial: Boolean&lt;Optional&gt; -     #     # Flag allowing partial BOC decoding when ABI doesn't describe the full body BOC. Controls decoder behaviour when after decoding all described in ABI params there are some data left in BOC: `true` - return decoded values `false` - return error of incomplete BOC deserialization (default)

    # RESPONSE: DecodedMessageBody
    # body_type: MessageBodyType -     #     # Type of the message body content.
    # name: String -     #     # Function or event name.
    # value: Value&lt;Optional&gt; -     #     # Parameters or result value.
    # header: FunctionHeader&lt;Optional&gt; -     #     # Function header.
```
```ruby
    # Decodes message body using provided body BOC and ABI.
    def decode_message_body(payload, &block)
    # INPUT: ParamsOfDecodeMessageBody
    # abi: Value -     #     # Contract ABI used to decode.
    # body: String -     #     # Message body BOC encoded in `base64`.
    # is_internal: Boolean -     #     # True if the body belongs to the internal message.
    # allow_partial: Boolean&lt;Optional&gt; -     #     # Flag allowing partial BOC decoding when ABI doesn't describe the full body BOC. Controls decoder behaviour when after decoding all described in ABI params there are some data left in BOC: `true` - return decoded values `false` - return error of incomplete BOC deserialization (default)

    # RESPONSE: DecodedMessageBody
    # body_type: MessageBodyType -     #     # Type of the message body content.
    # name: String -     #     # Function or event name.
    # value: Value&lt;Optional&gt; -     #     # Parameters or result value.
    # header: FunctionHeader&lt;Optional&gt; -     #     # Function header.
```
```ruby
    # Creates account state BOC    # Creates account state provided with one of these sets of data :
    # 1. BOC of code, BOC of data, BOC of library2. TVC (string in `base64`), keys, init params
    def encode_account(payload, &block)
    # INPUT: ParamsOfEncodeAccount
    # state_init: StateInitSource -     #     # Source of the account state init.
    # balance: BigInt&lt;Optional&gt; -     #     # Initial balance.
    # last_trans_lt: BigInt&lt;Optional&gt; -     #     # Initial value for the `last_trans_lt`.
    # last_paid: Number&lt;Optional&gt; -     #     # Initial value for the `last_paid`.
    # boc_cache: BocCacheType&lt;Optional&gt; -     #     # Cache type to put the result.    #     # The BOC itself returned if no cache type provided

    # RESPONSE: ResultOfEncodeAccount
    # account: String -     #     # Account BOC encoded in `base64`.
    # id: String -     #     # Account ID  encoded in `hex`.
```
```ruby
    # Decodes account data using provided data BOC and ABI.    # Note: this feature requires ABI 2.1 or higher.
    def decode_account_data(payload, &block)
    # INPUT: ParamsOfDecodeAccountData
    # abi: Value -     #     # Contract ABI
    # data: String -     #     # Data BOC or BOC handle
    # allow_partial: Boolean&lt;Optional&gt; -     #     # Flag allowing partial BOC decoding when ABI doesn't describe the full body BOC. Controls decoder behaviour when after decoding all described in ABI params there are some data left in BOC: `true` - return decoded values `false` - return error of incomplete BOC deserialization (default)

    # RESPONSE: ResultOfDecodeAccountData
    # data: Value -     #     # Decoded data as a JSON structure.
```
```ruby
    # Updates initial account data with initial values for the contract's static variables and owner's public key. This operation is applicable only for initial account data (before deploy). If the contract is already deployed, its data doesn't contain this data section any more.
    def update_initial_data(payload, &block)
    # INPUT: ParamsOfUpdateInitialData
    # abi: Value&lt;Optional&gt; -     #     # Contract ABI
    # data: String -     #     # Data BOC or BOC handle
    # initial_data: Value -     #     # List of initial values for contract's static variables.    #     # `abi` parameter should be provided to set initial data
    # initial_pubkey: String&lt;Optional&gt; -     #     # Initial account owner's public key to set into account data
    # boc_cache: BocCacheType&lt;Optional&gt; -     #     # Cache type to put the result. The BOC itself returned if no cache type provided.

    # RESPONSE: ResultOfUpdateInitialData
    # data: String -     #     # Updated data BOC or BOC handle
```
```ruby
    # Encodes initial account data with initial values for the contract's static variables and owner's public key into a data BOC that can be passed to `encode_tvc` function afterwards.    # This function is analogue of `tvm.buildDataInit` function in Solidity.
    def encode_initial_data(payload, &block)
    # INPUT: ParamsOfEncodeInitialData
    # abi: Value&lt;Optional&gt; -     #     # Contract ABI
    # initial_data: Value -     #     # List of initial values for contract's static variables.    #     # `abi` parameter should be provided to set initial data
    # initial_pubkey: String&lt;Optional&gt; -     #     # Initial account owner's public key to set into account data
    # boc_cache: BocCacheType&lt;Optional&gt; -     #     # Cache type to put the result. The BOC itself returned if no cache type provided.

    # RESPONSE: ResultOfEncodeInitialData
    # data: String -     #     # Updated data BOC or BOC handle
```
```ruby
    # Decodes initial values of a contract's static variables and owner's public key from account initial data This operation is applicable only for initial account data (before deploy). If the contract is already deployed, its data doesn't contain this data section any more.
    def decode_initial_data(payload, &block)
    # INPUT: ParamsOfDecodeInitialData
    # abi: Value&lt;Optional&gt; -     #     # Contract ABI.    #     # Initial data is decoded if this parameter is provided
    # data: String -     #     # Data BOC or BOC handle
    # allow_partial: Boolean&lt;Optional&gt; -     #     # Flag allowing partial BOC decoding when ABI doesn't describe the full body BOC. Controls decoder behaviour when after decoding all described in ABI params there are some data left in BOC: `true` - return decoded values `false` - return error of incomplete BOC deserialization (default)

    # RESPONSE: ResultOfDecodeInitialData
    # initial_data: Value&lt;Optional&gt; -     #     # List of initial values of contract's public variables.    #     # Initial data is decoded if `abi` input parameter is provided
    # initial_pubkey: String -     #     # Initial account owner's public key
```
```ruby
    # Decodes BOC into JSON as a set of provided parameters.    # Solidity functions use ABI types for [builder encoding](https://github.com/tonlabs/TON-Solidity-Compiler/blob/master/API.md#tvmbuilderstore).
    # The simplest way to decode such a BOC is to use ABI decoding.
    # ABI has it own rules for fields layout in cells so manually encodedBOC can not be described in terms of ABI rules.
    # To solve this problem we introduce a new ABI type `Ref(<ParamType>)`which allows to store `ParamType` ABI parameter in cell reference and, thus,decode manually encoded BOCs. This type is available only in `decode_boc` functionand will not be available in ABI messages encoding until it is included into some ABI revision.
    # Such BOC descriptions covers most users needs. If someone wants to decode some BOC whichcan not be described by these rules (i.e. BOC with TLB containing constructors of flagsdefining some parsing conditions) then they can decode the fields up to fork condition,check the parsed data manually, expand the parsing schema and then decode the whole BOCwith the full schema.
    def decode_boc(payload, &block)
    # INPUT: ParamsOfDecodeBoc
    # params: Array -     #     # Parameters to decode from BOC
    # boc: String -     #     # Data BOC or BOC handle
    # allow_partial: Boolean - 

    # RESPONSE: ResultOfDecodeBoc
    # data: Value -     #     # Decoded data as a JSON structure.
```
```ruby
    # Encodes given parameters in JSON into a BOC using param types from ABI.
    def encode_boc(payload, &block)
    # INPUT: ParamsOfAbiEncodeBoc
    # params: Array -     #     # Parameters to encode into BOC
    # data: Value -     #     # Parameters and values as a JSON structure
    # boc_cache: BocCacheType&lt;Optional&gt; -     #     # Cache type to put the result.    #     # The BOC itself returned if no cache type provided

    # RESPONSE: ResultOfAbiEncodeBoc
    # boc: String -     #     # BOC encoded as base64
```
</details>

<details>
  <summary>BOC</summary>

```ruby
    # Parses message boc into a JSON    # JSON structure is compatible with GraphQL API message object
    def parse_message(payload, &block)
    # INPUT: ParamsOfParse
    # boc: String -     #     # BOC encoded as base64

    # RESPONSE: ResultOfParse
    # parsed: Value -     #     # JSON containing parsed BOC
```
```ruby
    # Parses transaction boc into a JSON    # JSON structure is compatible with GraphQL API transaction object
    def parse_transaction(payload, &block)
    # INPUT: ParamsOfParse
    # boc: String -     #     # BOC encoded as base64

    # RESPONSE: ResultOfParse
    # parsed: Value -     #     # JSON containing parsed BOC
```
```ruby
    # Parses account boc into a JSON    # JSON structure is compatible with GraphQL API account object
    def parse_account(payload, &block)
    # INPUT: ParamsOfParse
    # boc: String -     #     # BOC encoded as base64

    # RESPONSE: ResultOfParse
    # parsed: Value -     #     # JSON containing parsed BOC
```
```ruby
    # Parses block boc into a JSON    # JSON structure is compatible with GraphQL API block object
    def parse_block(payload, &block)
    # INPUT: ParamsOfParse
    # boc: String -     #     # BOC encoded as base64

    # RESPONSE: ResultOfParse
    # parsed: Value -     #     # JSON containing parsed BOC
```
```ruby
    # Parses shardstate boc into a JSON    # JSON structure is compatible with GraphQL API shardstate object
    def parse_shardstate(payload, &block)
    # INPUT: ParamsOfParseShardstate
    # boc: String -     #     # BOC encoded as base64
    # id: String -     #     # Shardstate identificator
    # workchain_id: Number -     #     # Workchain shardstate belongs to

    # RESPONSE: ResultOfParse
    # parsed: Value -     #     # JSON containing parsed BOC
```
```ruby
    # Extract blockchain configuration from key block and also from zerostate.
    def get_blockchain_config(payload, &block)
    # INPUT: ParamsOfGetBlockchainConfig
    # block_boc: String -     #     # Key block BOC or zerostate BOC encoded as base64

    # RESPONSE: ResultOfGetBlockchainConfig
    # config_boc: String -     #     # Blockchain config BOC encoded as base64
```
```ruby
    # Calculates BOC root hash
    def get_boc_hash(payload, &block)
    # INPUT: ParamsOfGetBocHash
    # boc: String -     #     # BOC encoded as base64 or BOC handle

    # RESPONSE: ResultOfGetBocHash
    # hash: String -     #     # BOC root hash encoded with hex
```
```ruby
    # Calculates BOC depth
    def get_boc_depth(payload, &block)
    # INPUT: ParamsOfGetBocDepth
    # boc: String -     #     # BOC encoded as base64 or BOC handle

    # RESPONSE: ResultOfGetBocDepth
    # depth: Number -     #     # BOC root cell depth
```
```ruby
    # Extracts code from TVC contract image
    def get_code_from_tvc(payload, &block)
    # INPUT: ParamsOfGetCodeFromTvc
    # tvc: String -     #     # Contract TVC image or image BOC handle

    # RESPONSE: ResultOfGetCodeFromTvc
    # code: String -     #     # Contract code encoded as base64
```
```ruby
    # Get BOC from cache
    def cache_get(payload, &block)
    # INPUT: ParamsOfBocCacheGet
    # boc_ref: String -     #     # Reference to the cached BOC

    # RESPONSE: ResultOfBocCacheGet
    # boc: String&lt;Optional&gt; -     #     # BOC encoded as base64.
```
```ruby
    # Save BOC into cache
    def cache_set(payload, &block)
    # INPUT: ParamsOfBocCacheSet
    # boc: String -     #     # BOC encoded as base64 or BOC reference
    # cache_type: BocCacheType -     #     # Cache type

    # RESPONSE: ResultOfBocCacheSet
    # boc_ref: String -     #     # Reference to the cached BOC
```
```ruby
    # Unpin BOCs with specified pin.    # BOCs which don't have another pins will be removed from cache
    def cache_unpin(payload, &block)
    # INPUT: ParamsOfBocCacheUnpin
    # pin: String -     #     # Pinned name
    # boc_ref: String&lt;Optional&gt; -     #     # Reference to the cached BOC.    #     # If it is provided then only referenced BOC is unpinned
```
```ruby
    # Encodes bag of cells (BOC) with builder operations. This method provides the same functionality as Solidity TvmBuilder. Resulting BOC of this method can be passed into Solidity and C++ contracts as TvmCell type.
    def encode_boc(payload, &block)
    # INPUT: ParamsOfEncodeBoc
    # builder: Array -     #     # Cell builder operations.
    # boc_cache: BocCacheType&lt;Optional&gt; -     #     # Cache type to put the result. The BOC itself returned if no cache type provided.

    # RESPONSE: ResultOfEncodeBoc
    # boc: String -     #     # Encoded cell BOC or BOC cache key.
```
```ruby
    # Returns the contract code's salt if it is present.
    def get_code_salt(payload, &block)
    # INPUT: ParamsOfGetCodeSalt
    # code: String -     #     # Contract code BOC encoded as base64 or code BOC handle
    # boc_cache: BocCacheType&lt;Optional&gt; -     #     # Cache type to put the result. The BOC itself returned if no cache type provided.

    # RESPONSE: ResultOfGetCodeSalt
    # salt: String&lt;Optional&gt; -     #     # Contract code salt if present.    #     # BOC encoded as base64 or BOC handle
```
```ruby
    # Sets new salt to contract code.    # Returns the new contract code with salt.
    def set_code_salt(payload, &block)
    # INPUT: ParamsOfSetCodeSalt
    # code: String -     #     # Contract code BOC encoded as base64 or code BOC handle
    # salt: String -     #     # Code salt to set.    #     # BOC encoded as base64 or BOC handle
    # boc_cache: BocCacheType&lt;Optional&gt; -     #     # Cache type to put the result. The BOC itself returned if no cache type provided.

    # RESPONSE: ResultOfSetCodeSalt
    # code: String -     #     # Contract code with salt set.    #     # BOC encoded as base64 or BOC handle
```
```ruby
    # Decodes tvc into code, data, libraries and special options.
    def decode_tvc(payload, &block)
    # INPUT: ParamsOfDecodeTvc
    # tvc: String -     #     # Contract TVC image BOC encoded as base64 or BOC handle
    # boc_cache: BocCacheType&lt;Optional&gt; -     #     # Cache type to put the result. The BOC itself returned if no cache type provided.

    # RESPONSE: ResultOfDecodeTvc
    # code: String&lt;Optional&gt; -     #     # Contract code BOC encoded as base64 or BOC handle
    # code_hash: String&lt;Optional&gt; -     #     # Contract code hash
    # code_depth: Number&lt;Optional&gt; -     #     # Contract code depth
    # data: String&lt;Optional&gt; -     #     # Contract data BOC encoded as base64 or BOC handle
    # data_hash: String&lt;Optional&gt; -     #     # Contract data hash
    # data_depth: Number&lt;Optional&gt; -     #     # Contract data depth
    # library: String&lt;Optional&gt; -     #     # Contract library BOC encoded as base64 or BOC handle
    # tick: Boolean&lt;Optional&gt; -     #     # `special.tick` field.    #     # Specifies the contract ability to handle tick transactions
    # tock: Boolean&lt;Optional&gt; -     #     # `special.tock` field.    #     # Specifies the contract ability to handle tock transactions
    # split_depth: Number&lt;Optional&gt; -     #     # Is present and non-zero only in instances of large smart contracts
    # compiler_version: String&lt;Optional&gt; -     #     # Compiler version, for example 'sol 0.49.0'
```
```ruby
    # Encodes tvc from code, data, libraries ans special options (see input params)
    def encode_tvc(payload, &block)
    # INPUT: ParamsOfEncodeTvc
    # code: String&lt;Optional&gt; -     #     # Contract code BOC encoded as base64 or BOC handle
    # data: String&lt;Optional&gt; -     #     # Contract data BOC encoded as base64 or BOC handle
    # library: String&lt;Optional&gt; -     #     # Contract library BOC encoded as base64 or BOC handle
    # tick: Boolean&lt;Optional&gt; -     #     # `special.tick` field.    #     # Specifies the contract ability to handle tick transactions
    # tock: Boolean&lt;Optional&gt; -     #     # `special.tock` field.    #     # Specifies the contract ability to handle tock transactions
    # split_depth: Number&lt;Optional&gt; -     #     # Is present and non-zero only in instances of large smart contracts
    # boc_cache: BocCacheType&lt;Optional&gt; -     #     # Cache type to put the result. The BOC itself returned if no cache type provided.

    # RESPONSE: ResultOfEncodeTvc
    # tvc: String -     #     # Contract TVC image BOC encoded as base64 or BOC handle of boc_cache parameter was specified
```
```ruby
    # Encodes a message    # Allows to encode any external inbound message.
    def encode_external_in_message(payload, &block)
    # INPUT: ParamsOfEncodeExternalInMessage
    # src: String&lt;Optional&gt; -     #     # Source address.
    # dst: String -     #     # Destination address.
    # init: String&lt;Optional&gt; -     #     # Bag of cells with state init (used in deploy messages).
    # body: String&lt;Optional&gt; -     #     # Bag of cells with the message body encoded as base64.
    # boc_cache: BocCacheType&lt;Optional&gt; -     #     # Cache type to put the result.    #     # The BOC itself returned if no cache type provided

    # RESPONSE: ResultOfEncodeExternalInMessage
    # message: String -     #     # Message BOC encoded with `base64`.
    # message_id: String -     #     # Message id.
```
```ruby
    # Returns the compiler version used to compile the code.
    def get_compiler_version(payload, &block)
    # INPUT: ParamsOfGetCompilerVersion
    # code: String -     #     # Contract code BOC encoded as base64 or code BOC handle

    # RESPONSE: ResultOfGetCompilerVersion
    # version: String&lt;Optional&gt; -     #     # Compiler version, for example 'sol 0.49.0'
```
</details>

<details>
  <summary>PROCESSING</summary>

```ruby
    # Sends message to the network    # Sends message to the network and returns the last generated shard block of the destination accountbefore the message was sent. It will be required later for message processing.
    def send_message(payload, &block)
    # INPUT: ParamsOfSendMessage
    # message: String -     #     # Message BOC.
    # abi: Value&lt;Optional&gt; -     #     # Optional message ABI.    #     # If this parameter is specified and the message has the`expire` header then expiration time will be checked againstthe current time to prevent unnecessary sending of already expired message.
    #   #     # The `message already expired` error will be returned in thiscase.
    #   #     # Note, that specifying `abi` for ABI compliant contracts isstrongly recommended, so that proper processing strategy can bechosen.
    # send_events: Boolean -     #     # Flag for requesting events sending

    # RESPONSE: ResultOfSendMessage
    # shard_block_id: String -     #     # The last generated shard block of the message destination account before the message was sent.    #     # This block id must be used as a parameter of the`wait_for_transaction`.
    # sending_endpoints: Array -     #     # The list of endpoints to which the message was sent.    #     # This list id must be used as a parameter of the`wait_for_transaction`.
```
```ruby
    # Performs monitoring of the network for the result transaction of the external inbound message processing.    # `send_events` enables intermediate events, such as `WillFetchNextBlock`,`FetchNextBlockFailed` that may be useful for logging of new shard blocks creationduring message processing.
    # Note, that presence of the `abi` parameter is critical for ABIcompliant contracts. Message processing uses drasticallydifferent strategy for processing message for contracts whichABI includes "expire" header.
    # When the ABI header `expire` is present, the processing uses`message expiration` strategy:
    # - The maximum block gen time is set to  `message_expiration_timeout + transaction_wait_timeout`.
    # - When maximum block gen time is reached, the processing will  be finished with `MessageExpired` error.
    # When the ABI header `expire` isn't present or `abi` parameterisn't specified, the processing uses `transaction waiting`strategy:
    # - The maximum block gen time is set to  `now() + transaction_wait_timeout`.
    # - If maximum block gen time is reached and no result transaction is found,the processing will exit with an error.
    def wait_for_transaction(payload, &block)
    # INPUT: ParamsOfWaitForTransaction
    # abi: Value&lt;Optional&gt; -     #     # Optional ABI for decoding the transaction result.    #     # If it is specified, then the output messages' bodies will bedecoded according to this ABI.
    #   #     # The `abi_decoded` result field will be filled out.
    # message: String -     #     # Message BOC.    #     # Encoded with `base64`.
    # shard_block_id: String -     #     # The last generated block id of the destination account shard before the message was sent.    #     # You must provide the same value as the `send_message` has returned.
    # send_events: Boolean -     #     # Flag that enables/disables intermediate events
    # sending_endpoints: Array&lt;Optional&gt; -     #     # The list of endpoints to which the message was sent.    #     # Use this field to get more informative errors.
    #   #     # Provide the same value as the `send_message` has returned.
    #   #     # If the message was not delivered (expired), SDK will log the endpoint URLs, used for its sending.

    # RESPONSE: ResultOfProcessMessage
    # transaction: Value -     #     # Parsed transaction.    #     # In addition to the regular transaction fields there is a`boc` field encoded with `base64` which contains sourcetransaction BOC.
    # out_messages: Array -     #     # List of output messages' BOCs.    #     # Encoded as `base64`
    # decoded: DecodedOutput&lt;Optional&gt; -     #     # Optional decoded message bodies according to the optional `abi` parameter.
    # fees: TransactionFees -     #     # Transaction fees
```
```ruby
    # Creates message, sends it to the network and monitors its processing.    # Creates ABI-compatible message,sends it to the network and monitors for the result transaction.
    # Decodes the output messages' bodies.
    # If contract's ABI includes "expire" header, thenSDK implements retries in case of unsuccessful message delivery within the expirationtimeout: SDK recreates the message, sends it and processes it again.
    # The intermediate events, such as `WillFetchFirstBlock`, `WillSend`, `DidSend`,`WillFetchNextBlock`, etc - are switched on/off by `send_events` flagand logged into the supplied callback function.
    # The retry configuration parameters are defined in the client's `NetworkConfig` and `AbiConfig`.
    # If contract's ABI does not include "expire" headerthen, if no transaction is found within the network timeout (see config parameter ), exits with error.
    def process_message(payload, &block)
    # INPUT: ParamsOfProcessMessage
    # message_encode_params: ParamsOfEncodeMessage -     #     # Message encode parameters.
    # send_events: Boolean -     #     # Flag for requesting events sending

    # RESPONSE: ResultOfProcessMessage
    # transaction: Value -     #     # Parsed transaction.    #     # In addition to the regular transaction fields there is a`boc` field encoded with `base64` which contains sourcetransaction BOC.
    # out_messages: Array -     #     # List of output messages' BOCs.    #     # Encoded as `base64`
    # decoded: DecodedOutput&lt;Optional&gt; -     #     # Optional decoded message bodies according to the optional `abi` parameter.
    # fees: TransactionFees -     #     # Transaction fees
```
</details>

<details>
  <summary>UTILS</summary>

```ruby
    # Converts address from any TON format to any TON format
    def convert_address(payload, &block)
    # INPUT: ParamsOfConvertAddress
    # address: String -     #     # Account address in any TON format.
    # output_format: AddressStringFormat -     #     # Specify the format to convert to.

    # RESPONSE: ResultOfConvertAddress
    # address: String -     #     # Address in the specified format
```
```ruby
    # Validates and returns the type of any TON address.    # Address types are the following`0:919db8e740d50bf349df2eea03fa30c385d846b991ff5542e67098ee833fc7f7` - standard TON address mostcommonly used in all cases. Also called as hex address`919db8e740d50bf349df2eea03fa30c385d846b991ff5542e67098ee833fc7f7` - account ID. A part of fulladdress. Identifies account inside particular workchain`EQCRnbjnQNUL80nfLuoD+jDDhdhGuZH/VULmcJjugz/H9wam` - base64 address. Also called "user-friendly".
    # Was used at the beginning of TON. Now it is supported for compatibility
    def get_address_type(payload, &block)
    # INPUT: ParamsOfGetAddressType
    # address: String -     #     # Account address in any TON format.

    # RESPONSE: ResultOfGetAddressType
    # address_type: AccountAddressType -     #     # Account address type.
```
```ruby
    # Calculates storage fee for an account over a specified time period
    def calc_storage_fee(payload, &block)
    # INPUT: ParamsOfCalcStorageFee
    # account: String - 
    # period: Number - 

    # RESPONSE: ResultOfCalcStorageFee
    # fee: String - 
```
```ruby
    # Compresses data using Zstandard algorithm
    def compress_zstd(payload, &block)
    # INPUT: ParamsOfCompressZstd
    # uncompressed: String -     #     # Uncompressed data.    #     # Must be encoded as base64.
    # level: Number&lt;Optional&gt; -     #     # Compression level, from 1 to 21. Where: 1 - lowest compression level (fastest compression); 21 - highest compression level (slowest compression). If level is omitted, the default compression level is used (currently `3`).

    # RESPONSE: ResultOfCompressZstd
    # compressed: String -     #     # Compressed data.    #     # Must be encoded as base64.
```
```ruby
    # Decompresses data using Zstandard algorithm
    def decompress_zstd(payload, &block)
    # INPUT: ParamsOfDecompressZstd
    # compressed: String -     #     # Compressed data.    #     # Must be encoded as base64.

    # RESPONSE: ResultOfDecompressZstd
    # decompressed: String -     #     # Decompressed data.    #     # Must be encoded as base64.
```
</details>

<details>
  <summary>TVM</summary>

```ruby
    # Emulates all the phases of contract execution locally    # Performs all the phases of contract execution on Transaction Executor -the same component that is used on Validator Nodes.
    # Can be used for contract debugging, to find out the reason why a message was not delivered successfully.
    # Validators throw away the failed external inbound messages (if they failed bedore `ACCEPT`) in the real network.
    # This is why these messages are impossible to debug in the real network.
    # With the help of run_executor you can do that. In fact, `process_message` functionperforms local check with `run_executor` if there was no transaction as a result of processingand returns the error, if there is one.
    # Another use case to use `run_executor` is to estimate fees for message execution.
    # Set  `AccountForExecutor::Account.unlimited_balance`to `true` so that emulation will not depend on the actual balance.
    # This may be needed to calculate deploy fees for an account that does not exist yet.
    # JSON with fees is in `fees` field of the result.
    # One more use case - you can produce the sequence of operations,thus emulating the sequential contract calls locally.
    # And so on.
    # Transaction executor requires account BOC (bag of cells) as a parameter.
    # To get the account BOC - use `net.query` method to download it from GraphQL API(field `boc` of `account`) or generate it with `abi.encode_account` method.
    # Also it requires message BOC. To get the message BOC - use `abi.encode_message` or `abi.encode_internal_message`.
    # If you need this emulation to be as precise as possible (for instance - emulate transactionwith particular lt in particular block or use particular blockchain config,downloaded from a particular key block - then specify `execution_options` parameter.
    # If you need to see the aborted transaction as a result, not as an error, set `skip_transaction_check` to `true`.
    def run_executor(payload, &block)
    # INPUT: ParamsOfRunExecutor
    # message: String -     #     # Input message BOC.    #     # Must be encoded as base64.
    # account: AccountForExecutor -     #     # Account to run on executor
    # execution_options: ExecutionOptions&lt;Optional&gt; -     #     # Execution options.
    # abi: Value&lt;Optional&gt; -     #     # Contract ABI for decoding output messages
    # skip_transaction_check: Boolean&lt;Optional&gt; -     #     # Skip transaction check flag
    # boc_cache: BocCacheType&lt;Optional&gt; -     #     # Cache type to put the result.    #     # The BOC itself returned if no cache type provided
    # return_updated_account: Boolean&lt;Optional&gt; -     #     # Return updated account flag.    #     # Empty string is returned if the flag is `false`

    # RESPONSE: ResultOfRunExecutor
    # transaction: Value -     #     # Parsed transaction.    #     # In addition to the regular transaction fields there is a`boc` field encoded with `base64` which contains sourcetransaction BOC.
    # out_messages: Array -     #     # List of output messages' BOCs.    #     # Encoded as `base64`
    # decoded: DecodedOutput&lt;Optional&gt; -     #     # Optional decoded message bodies according to the optional `abi` parameter.
    # account: String -     #     # Updated account state BOC.    #     # Encoded as `base64`
    # fees: TransactionFees -     #     # Transaction fees
```
```ruby
    # Executes get-methods of ABI-compatible contracts    # Performs only a part of compute phase of transaction executionthat is used to run get-methods of ABI-compatible contracts.
    # If you try to run get-methods with `run_executor` you will get an error, because it checks ACCEPT and exitsif there is none, which is actually true for get-methods.
    #  To get the account BOC (bag of cells) - use `net.query` method to download it from GraphQL API(field `boc` of `account`) or generate it with `abi.encode_account method`.
    # To get the message BOC - use `abi.encode_message` or prepare it any other way, for instance, with FIFT script.
    # Attention! Updated account state is produces as well, but only`account_state.storage.state.data`  part of the BOC is updated.
    def run_tvm(payload, &block)
    # INPUT: ParamsOfRunTvm
    # message: String -     #     # Input message BOC.    #     # Must be encoded as base64.
    # account: String -     #     # Account BOC.    #     # Must be encoded as base64.
    # execution_options: ExecutionOptions&lt;Optional&gt; -     #     # Execution options.
    # abi: Value&lt;Optional&gt; -     #     # Contract ABI for decoding output messages
    # boc_cache: BocCacheType&lt;Optional&gt; -     #     # Cache type to put the result.    #     # The BOC itself returned if no cache type provided
    # return_updated_account: Boolean&lt;Optional&gt; -     #     # Return updated account flag.    #     # Empty string is returned if the flag is `false`

    # RESPONSE: ResultOfRunTvm
    # out_messages: Array -     #     # List of output messages' BOCs.    #     # Encoded as `base64`
    # decoded: DecodedOutput&lt;Optional&gt; -     #     # Optional decoded message bodies according to the optional `abi` parameter.
    # account: String -     #     # Updated account state BOC.    #     # Encoded as `base64`. Attention! Only `account_state.storage.state.data` part of the BOC is updated.
```
```ruby
    # Executes a get-method of FIFT contract    # Executes a get-method of FIFT contract that fulfills the smc-guidelines https://test.ton.org/smc-guidelines.txtand returns the result data from TVM's stack
    def run_get(payload, &block)
    # INPUT: ParamsOfRunGet
    # account: String -     #     # Account BOC in `base64`
    # function_name: String -     #     # Function name
    # input: Value -     #     # Input parameters
    # execution_options: ExecutionOptions&lt;Optional&gt; -     #     # Execution options
    # tuple_list_as_array: Boolean&lt;Optional&gt; -     #     # Convert lists based on nested tuples in the **result** into plain arrays.    #     # Default is `false`. Input parameters may use any of lists representationsIf you receive this error on Web: "Runtime error. Unreachable code should not be executed...",set this flag to true.
    #   #     # This may happen, for example, when elector contract contains too many participants

    # RESPONSE: ResultOfRunGet
    # output: Value -     #     # Values returned by get-method on stack
```
</details>

<details>
  <summary>NET</summary>

```ruby
    # Performs DAppServer GraphQL query.
    def query(payload, &block)
    # INPUT: ParamsOfQuery
    # query: String -     #     # GraphQL query text.
    # variables: Value -     #     # Variables used in query.    #     # Must be a map with named values that can be used in query.

    # RESPONSE: ResultOfQuery
    # result: Value -     #     # Result provided by DAppServer.
```
```ruby
    # Performs multiple queries per single fetch.
    def batch_query(payload, &block)
    # INPUT: ParamsOfBatchQuery
    # operations: Array -     #     # List of query operations that must be performed per single fetch.

    # RESPONSE: ResultOfBatchQuery
    # results: Array -     #     # Result values for batched queries.    #     # Returns an array of values. Each value corresponds to `queries` item.
```
```ruby
    # Queries collection data    # Queries data that satisfies the `filter` conditions,limits the number of returned records and orders them.
    # The projection fields are limited to `result` fields
    def query_collection(payload, &block)
    # INPUT: ParamsOfQueryCollection
    # collection: String -     #     # Collection name (accounts, blocks, transactions, messages, block_signatures)
    # filter: Value -     #     # Collection filter
    # result: String -     #     # Projection (result) string
    # order: Array&lt;Optional&gt; -     #     # Sorting order
    # limit: Number&lt;Optional&gt; -     #     # Number of documents to return

    # RESPONSE: ResultOfQueryCollection
    # result: Array -     #     # Objects that match the provided criteria
```
```ruby
    # Aggregates collection data.    # Aggregates values from the specified `fields` for recordsthat satisfies the `filter` conditions,
    def aggregate_collection(payload, &block)
    # INPUT: ParamsOfAggregateCollection
    # collection: String -     #     # Collection name (accounts, blocks, transactions, messages, block_signatures)
    # filter: Value -     #     # Collection filter
    # fields: Array&lt;Optional&gt; -     #     # Projection (result) string

    # RESPONSE: ResultOfAggregateCollection
    # values: Value -     #     # Values for requested fields.    #     # Returns an array of strings. Each string refers to the corresponding `fields` item.
    #   #     # Numeric value is returned as a decimal string representations.
```
```ruby
    # Returns an object that fulfills the conditions or waits for its appearance    # Triggers only once.
    # If object that satisfies the `filter` conditionsalready exists - returns it immediately.
    # If not - waits for insert/update of data within the specified `timeout`,and returns it.
    # The projection fields are limited to `result` fields
    def wait_for_collection(payload, &block)
    # INPUT: ParamsOfWaitForCollection
    # collection: String -     #     # Collection name (accounts, blocks, transactions, messages, block_signatures)
    # filter: Value -     #     # Collection filter
    # result: String -     #     # Projection (result) string
    # timeout: Number&lt;Optional&gt; -     #     # Query timeout

    # RESPONSE: ResultOfWaitForCollection
    # result: Value -     #     # First found object that matches the provided criteria
```
```ruby
    # Cancels a subscription    # Cancels a subscription specified by its handle.
    def unsubscribe(payload, &block)
    # INPUT: ResultOfSubscribeCollection
    # handle: Number -     #     # Subscription handle.    #     # Must be closed with `unsubscribe`
```
```ruby
    # Creates a collection subscription    # Triggers for each insert/update of data that satisfiesthe `filter` conditions.
    # The projection fields are limited to `result` fields.
    # The subscription is a persistent communication channel betweenclient and Free TON Network.
    # All changes in the blockchain will be reflected in realtime.
    # Changes means inserts and updates of the blockchain entities.
    # ### Important Notes on SubscriptionsUnfortunately sometimes the connection with the network brakes down.
    # In this situation the library attempts to reconnect to the network.
    # This reconnection sequence can take significant time.
    # All of this time the client is disconnected from the network.
    # Bad news is that all blockchain changes that happened whilethe client was disconnected are lost.
    # Good news is that the client report errors to the callback whenit loses and resumes connection.
    # So, if the lost changes are important to the application thenthe application must handle these error reports.
    # Library reports errors with `responseType` == 101and the error object passed via `params`.
    # When the library has successfully reconnectedthe application receives callback with`responseType` == 101 and `params.code` == 614 (NetworkModuleResumed).
    # Application can use several ways to handle this situation:
    # - If application monitors changes for the single blockchainobject (for example specific account):  applicationcan perform a query for this object and handle actual data as aregular data from the subscription.
    # - If application monitors sequence of some blockchain objects(for example transactions of the specific account): application mustrefresh all cached (or visible to user) lists where this sequences presents.
    def subscribe_collection(payload, &block)
    # INPUT: ParamsOfSubscribeCollection
    # collection: String -     #     # Collection name (accounts, blocks, transactions, messages, block_signatures)
    # filter: Value -     #     # Collection filter
    # result: String -     #     # Projection (result) string

    # RESPONSE: ResultOfSubscribeCollection
    # handle: Number -     #     # Subscription handle.    #     # Must be closed with `unsubscribe`
```
```ruby
    # Creates a subscription    # The subscription is a persistent communication channel betweenclient and Everscale Network.
    # ### Important Notes on SubscriptionsUnfortunately sometimes the connection with the network brakes down.
    # In this situation the library attempts to reconnect to the network.
    # This reconnection sequence can take significant time.
    # All of this time the client is disconnected from the network.
    # Bad news is that all changes that happened whilethe client was disconnected are lost.
    # Good news is that the client report errors to the callback whenit loses and resumes connection.
    # So, if the lost changes are important to the application thenthe application must handle these error reports.
    # Library reports errors with `responseType` == 101and the error object passed via `params`.
    # When the library has successfully reconnectedthe application receives callback with`responseType` == 101 and `params.code` == 614 (NetworkModuleResumed).
    # Application can use several ways to handle this situation:
    # - If application monitors changes for the singleobject (for example specific account):  applicationcan perform a query for this object and handle actual data as aregular data from the subscription.
    # - If application monitors sequence of some objects(for example transactions of the specific account): application mustrefresh all cached (or visible to user) lists where this sequences presents.
    def subscribe(payload, &block)
    # INPUT: ParamsOfSubscribe
    # subscription: String -     #     # GraphQL subscription text.
    # variables: Value -     #     # Variables used in subscription.    #     # Must be a map with named values that can be used in query.

    # RESPONSE: ResultOfSubscribeCollection
    # handle: Number -     #     # Subscription handle.    #     # Must be closed with `unsubscribe`
```
```ruby
    # Suspends network module to stop any network activity
    def suspend(&block)
```
```ruby
    # Resumes network module to enable network activity
    def resume(&block)
```
```ruby
    # Returns ID of the last block in a specified account shard
    def find_last_shard_block(payload, &block)
    # INPUT: ParamsOfFindLastShardBlock
    # address: String -     #     # Account address

    # RESPONSE: ResultOfFindLastShardBlock
    # block_id: String -     #     # Account shard last block ID
```
```ruby
    # Requests the list of alternative endpoints from server
    def fetch_endpoints(&block)

    # RESPONSE: EndpointsSet
    # endpoints: Array -     #     # List of endpoints provided by server
```
```ruby
    # Sets the list of endpoints to use on reinit
    def set_endpoints(payload, &block)
    # INPUT: EndpointsSet
    # endpoints: Array -     #     # List of endpoints provided by server
```
```ruby
    # Requests the list of alternative endpoints from server
    def get_endpoints(&block)

    # RESPONSE: ResultOfGetEndpoints
    # query: String -     #     # Current query endpoint
    # endpoints: Array -     #     # List of all endpoints used by client
```
```ruby
    # Allows to query and paginate through the list of accounts that the specified account has interacted with, sorted by the time of the last internal message between accounts    # *Attention* this query retrieves data from 'Counterparties' service which is not supported inthe opensource version of DApp Server (and will not be supported) as well as in Evernode SE (will be supported in SE in future),but is always accessible via [EVER OS Clouds](../ton-os-api/networks.md)
    def query_counterparties(payload, &block)
    # INPUT: ParamsOfQueryCounterparties
    # account: String -     #     # Account address
    # result: String -     #     # Projection (result) string
    # first: Number&lt;Optional&gt; -     #     # Number of counterparties to return
    # after: String&lt;Optional&gt; -     #     # `cursor` field of the last received result

    # RESPONSE: ResultOfQueryCollection
    # result: Array -     #     # Objects that match the provided criteria
```
```ruby
    # Returns a tree of transactions triggered by a specific message.    # Performs recursive retrieval of a transactions tree produced by a specific message:
    # in_msg -> dst_transaction -> out_messages -> dst_transaction -> ...
    # If the chain of transactions execution is in progress while the function is running,it will wait for the next transactions to appear until the full tree or more than 50 transactionsare received.
    # All the retrieved messages and transactions are includedinto `result.messages` and `result.transactions` respectively.
    # Function reads transactions layer by layer, by pages of 20 transactions.
    # The retrieval prosess goes like this:
    # Let's assume we have an infinite chain of transactions and each transaction generates 5 messages.
    # 1. Retrieve 1st message (input parameter) and corresponding transaction - put it into result.
    # It is the first level of the tree of transactions - its root.
    # Retrieve 5 out message ids from the transaction for next steps.
    # 2. Retrieve 5 messages and corresponding transactions on the 2nd layer. Put them into result.
    # Retrieve 5*5 out message ids from these transactions for next steps3. Retrieve 20 (size of the page) messages and transactions (3rd layer) and 20*5=100 message ids (4th layer).
    # 4. Retrieve the last 5 messages and 5 transactions on the 3rd layer + 15 messages and transactions (of 100) from the 4th layer+ 25 message ids of the 4th layer + 75 message ids of the 5th layer.
    # 5. Retrieve 20 more messages and 20 more transactions of the 4th layer + 100 more message ids of the 5th layer.
    # 6. Now we have 1+5+20+20+20 = 66 transactions, which is more than 50. Function exits with the tree of1m->1t->5m->5t->25m->25t->35m->35t. If we see any message ids in the last transactions out_msgs, which don't havecorresponding messages in the function result, it means that the full tree was not received and we need to continue iteration.
    # To summarize, it is guaranteed that each message in `result.messages` has the corresponding transactionin the `result.transactions`.
    # But there is no guarantee that all messages from transactions `out_msgs` arepresented in `result.messages`.
    # So the application has to continue retrieval for missing messages if it requires.
    def query_transaction_tree(payload, &block)
    # INPUT: ParamsOfQueryTransactionTree
    # in_msg: String -     #     # Input message id.
    # abi_registry: Array&lt;Optional&gt; -     #     # List of contract ABIs that will be used to decode message bodies. Library will try to decode each returned message body using any ABI from the registry.
    # timeout: Number&lt;Optional&gt; -     #     # Timeout used to limit waiting time for the missing messages and transaction.    #     # If some of the following messages and transactions are missing yetThe maximum waiting time is regulated by this option.
    #   #     # Default value is 60000 (1 min).

    # RESPONSE: ResultOfQueryTransactionTree
    # messages: Array -     #     # Messages.
    # transactions: Array -     #     # Transactions.
```
```ruby
    # Creates block iterator.    # Block iterator uses robust iteration methods that guaranties that everyblock in the specified range isn't missed or iterated twice.
    # Iterated range can be reduced with some filters:
    # - `start_time` – the bottom time range. Only blocks with `gen_utime`more or equal to this value is iterated. If this parameter is omitted then there isno bottom time edge, so all blocks since zero state is iterated.
    # - `end_time` – the upper time range. Only blocks with `gen_utime`less then this value is iterated. If this parameter is omitted then there isno upper time edge, so iterator never finishes.
    # - `shard_filter` – workchains and shard prefixes that reduce the set of interestingblocks. Block conforms to the shard filter if it belongs to the filter workchainand the first bits of block's `shard` fields matches to the shard prefix.
    # Only blocks with suitable shard are iterated.
    # Items iterated is a JSON objects with block data. The minimal set of returnedfields is:
    # ```textidgen_utimeworkchain_idshardafter_splitafter_mergeprev_ref {    root_hash}prev_alt_ref {    root_hash}```Application can request additional fields in the `result` parameter.
    # Application should call the `remove_iterator` when iterator is no longer required.
    def create_block_iterator(payload, &block)
    # INPUT: ParamsOfCreateBlockIterator
    # start_time: Number&lt;Optional&gt; -     #     # Starting time to iterate from.    #     # If the application specifies this parameter then the iterationincludes blocks with `gen_utime` >= `start_time`.
    #   #     # Otherwise the iteration starts from zero state.
    #   #     # Must be specified in seconds.
    # end_time: Number&lt;Optional&gt; -     #     # Optional end time to iterate for.    #     # If the application specifies this parameter then the iterationincludes blocks with `gen_utime` < `end_time`.
    #   #     # Otherwise the iteration never stops.
    #   #     # Must be specified in seconds.
    # shard_filter: Array&lt;Optional&gt; -     #     # Shard prefix filter.    #     # If the application specifies this parameter and it is not the empty arraythen the iteration will include items related to accounts that belongs tothe specified shard prefixes.
    #   #     # Shard prefix must be represented as a string "workchain:prefix".
    #   #     # Where `workchain` is a signed integer and the `prefix` if a hexadecimalrepresentation if the 64-bit unsigned integer with tagged shard prefix.
    #   #     # For example: "0:3800000000000000".
    # result: String&lt;Optional&gt; -     #     # Projection (result) string.    #     # List of the fields that must be returned for iterated items.
    #   #     # This field is the same as the `result` parameter ofthe `query_collection` function.
    #   #     # Note that iterated items can contains additional fields that arenot requested in the `result`.

    # RESPONSE: RegisteredIterator
    # handle: Number -     #     # Iterator handle.    #     # Must be removed using `remove_iterator`when it is no more needed for the application.
```
```ruby
    # Resumes block iterator.    # The iterator stays exactly at the same position where the `resume_state` was catched.
    # Application should call the `remove_iterator` when iterator is no longer required.
    def resume_block_iterator(payload, &block)
    # INPUT: ParamsOfResumeBlockIterator
    # resume_state: Value -     #     # Iterator state from which to resume.    #     # Same as value returned from `iterator_next`.

    # RESPONSE: RegisteredIterator
    # handle: Number -     #     # Iterator handle.    #     # Must be removed using `remove_iterator`when it is no more needed for the application.
```
```ruby
    # Creates transaction iterator.    # Transaction iterator uses robust iteration methods that guaranty that everytransaction in the specified range isn't missed or iterated twice.
    # Iterated range can be reduced with some filters:
    # - `start_time` – the bottom time range. Only transactions with `now`more or equal to this value are iterated. If this parameter is omitted then there isno bottom time edge, so all the transactions since zero state are iterated.
    # - `end_time` – the upper time range. Only transactions with `now`less then this value are iterated. If this parameter is omitted then there isno upper time edge, so iterator never finishes.
    # - `shard_filter` – workchains and shard prefixes that reduce the set of interestingaccounts. Account address conforms to the shard filter ifit belongs to the filter workchain and the first bits of address match tothe shard prefix. Only transactions with suitable account addresses are iterated.
    # - `accounts_filter` – set of account addresses whose transactions must be iterated.
    # Note that accounts filter can conflict with shard filter so application must combinethese filters carefully.
    # Iterated item is a JSON objects with transaction data. The minimal set of returnedfields is:
    # ```textidaccount_addrnowbalance_delta(format:DEC)bounce { bounce_type }in_message {    id    value(format:DEC)    msg_type    src}out_messages {    id    value(format:DEC)    msg_type    dst}```Application can request an additional fields in the `result` parameter.
    # Another parameter that affects on the returned fields is the `include_transfers`.
    # When this parameter is `true` the iterator computes and adds `transfer` field containinglist of the useful `TransactionTransfer` objects.
    # Each transfer is calculated from the particular message related to the transactionand has the following structure:
    # - message – source message identifier.
    # - isBounced – indicates that the transaction is bounced, which means the value will be returned back to the sender.
    # - isDeposit – indicates that this transfer is the deposit (true) or withdraw (false).
    # - counterparty – account address of the transfer source or destination depending on `isDeposit`.
    # - value – amount of nano tokens transferred. The value is represented as a decimal stringbecause the actual value can be more precise than the JSON number can represent. Applicationmust use this string carefully – conversion to number can follow to loose of precision.
    # Application should call the `remove_iterator` when iterator is no longer required.
    def create_transaction_iterator(payload, &block)
    # INPUT: ParamsOfCreateTransactionIterator
    # start_time: Number&lt;Optional&gt; -     #     # Starting time to iterate from.    #     # If the application specifies this parameter then the iterationincludes blocks with `gen_utime` >= `start_time`.
    #   #     # Otherwise the iteration starts from zero state.
    #   #     # Must be specified in seconds.
    # end_time: Number&lt;Optional&gt; -     #     # Optional end time to iterate for.    #     # If the application specifies this parameter then the iterationincludes blocks with `gen_utime` < `end_time`.
    #   #     # Otherwise the iteration never stops.
    #   #     # Must be specified in seconds.
    # shard_filter: Array&lt;Optional&gt; -     #     # Shard prefix filters.    #     # If the application specifies this parameter and it is not an empty arraythen the iteration will include items related to accounts that belongs tothe specified shard prefixes.
    #   #     # Shard prefix must be represented as a string "workchain:prefix".
    #   #     # Where `workchain` is a signed integer and the `prefix` if a hexadecimalrepresentation if the 64-bit unsigned integer with tagged shard prefix.
    #   #     # For example: "0:3800000000000000".
    #   #     # Account address conforms to the shard filter ifit belongs to the filter workchain and the first bits of address match tothe shard prefix. Only transactions with suitable account addresses are iterated.
    # accounts_filter: Array&lt;Optional&gt; -     #     # Account address filter.    #     # Application can specify the list of accounts for whichit wants to iterate transactions.
    #   #     # If this parameter is missing or an empty list then the library iteratestransactions for all accounts that pass the shard filter.
    #   #     # Note that the library doesn't detect conflicts between the account filter and the shard filterif both are specified.
    #   #     # So it is an application responsibility to specify the correct filter combination.
    # result: String&lt;Optional&gt; -     #     # Projection (result) string.    #     # List of the fields that must be returned for iterated items.
    #   #     # This field is the same as the `result` parameter ofthe `query_collection` function.
    #   #     # Note that iterated items can contain additional fields that arenot requested in the `result`.
    # include_transfers: Boolean&lt;Optional&gt; -     #     # Include `transfers` field in iterated transactions.    #     # If this parameter is `true` then each transaction contains field`transfers` with list of transfer. See more about this structure in function description.

    # RESPONSE: RegisteredIterator
    # handle: Number -     #     # Iterator handle.    #     # Must be removed using `remove_iterator`when it is no more needed for the application.
```
```ruby
    # Resumes transaction iterator.    # The iterator stays exactly at the same position where the `resume_state` was caught.
    # Note that `resume_state` doesn't store the account filter. If the application requiresto use the same account filter as it was when the iterator was created then the applicationmust pass the account filter again in `accounts_filter` parameter.
    # Application should call the `remove_iterator` when iterator is no longer required.
    def resume_transaction_iterator(payload, &block)
    # INPUT: ParamsOfResumeTransactionIterator
    # resume_state: Value -     #     # Iterator state from which to resume.    #     # Same as value returned from `iterator_next`.
    # accounts_filter: Array&lt;Optional&gt; -     #     # Account address filter.    #     # Application can specify the list of accounts for whichit wants to iterate transactions.
    #   #     # If this parameter is missing or an empty list then the library iteratestransactions for all accounts that passes the shard filter.
    #   #     # Note that the library doesn't detect conflicts between the account filter and the shard filterif both are specified.
    #   #     # So it is the application's responsibility to specify the correct filter combination.

    # RESPONSE: RegisteredIterator
    # handle: Number -     #     # Iterator handle.    #     # Must be removed using `remove_iterator`when it is no more needed for the application.
```
```ruby
    # Returns next available items.    # In addition to available items this function returns the `has_more` flagindicating that the iterator isn't reach the end of the iterated range yet.
    # This function can return the empty list of available items butindicates that there are more items is available.
    # This situation appears when the iterator doesn't reach iterated rangebut database doesn't contains available items yet.
    # If application requests resume state in `return_resume_state` parameterthen this function returns `resume_state` that can be used later toresume the iteration from the position after returned items.
    # The structure of the items returned depends on the iterator used.
    # See the description to the appropriated iterator creation function.
    def iterator_next(payload, &block)
    # INPUT: ParamsOfIteratorNext
    # iterator: Number -     #     # Iterator handle
    # limit: Number&lt;Optional&gt; -     #     # Maximum count of the returned items.    #     # If value is missing or is less than 1 the library uses 1.
    # return_resume_state: Boolean&lt;Optional&gt; -     #     # Indicates that function must return the iterator state that can be used for resuming iteration.

    # RESPONSE: ResultOfIteratorNext
    # items: Array -     #     # Next available items.    #     # Note that `iterator_next` can return an empty items and `has_more` equals to `true`.
    #   #     # In this case the application have to continue iteration.
    #   #     # Such situation can take place when there is no data yet butthe requested `end_time` is not reached.
    # has_more: Boolean -     #     # Indicates that there are more available items in iterated range.
    # resume_state: Value&lt;Optional&gt; -     #     # Optional iterator state that can be used for resuming iteration.    #     # This field is returned only if the `return_resume_state` parameteris specified.
    #   #     # Note that `resume_state` corresponds to the iteration positionafter the returned items.
```
```ruby
    # Removes an iterator    # Frees all resources allocated in library to serve iterator.
    # Application always should call the `remove_iterator` when iteratoris no longer required.
    def remove_iterator(payload, &block)
    # INPUT: RegisteredIterator
    # handle: Number -     #     # Iterator handle.    #     # Must be removed using `remove_iterator`when it is no more needed for the application.
```
</details>

<details>
  <summary>DEBOT</summary>

```ruby
    # [UNSTABLE](UNSTABLE.md) Creates and instance of DeBot.    # Downloads debot smart contract (code and data) from blockchain and createsan instance of Debot Engine for it.
    # # RemarksIt does not switch debot to context 0. Browser Callbacks are not called.
    def init(payload, &block)
    # INPUT: ParamsOfInit
    # address: String -     #     # Debot smart contract address

    # RESPONSE: RegisteredDebot
    # debot_handle: DebotHandle -     #     # Debot handle which references an instance of debot engine.
    # debot_abi: String -     #     # Debot abi as json string.
    # info: DebotInfo -     #     # Debot metadata.
```
```ruby
    # [UNSTABLE](UNSTABLE.md) Starts the DeBot.    # Downloads debot smart contract from blockchain and switches it tocontext zero.
    # This function must be used by Debot Browser to start a dialog with debot.
    # While the function is executing, several Browser Callbacks can be called,since the debot tries to display all actions from the context 0 to the user.
    # When the debot starts SDK registers `BrowserCallbacks` AppObject.
    # Therefore when `debote.remove` is called the debot is being deleted and the callback is calledwith `finish`=`true` which indicates that it will never be used again.
    def start(payload, &block)
    # INPUT: ParamsOfStart
    # debot_handle: DebotHandle -     #     # Debot handle which references an instance of debot engine.
```
```ruby
    # [UNSTABLE](UNSTABLE.md) Fetches DeBot metadata from blockchain.    # Downloads DeBot from blockchain and creates and fetches its metadata.
    def fetch(payload, &block)
    # INPUT: ParamsOfFetch
    # address: String -     #     # Debot smart contract address.

    # RESPONSE: ResultOfFetch
    # info: DebotInfo -     #     # Debot metadata.
```
```ruby
    # [UNSTABLE](UNSTABLE.md) Executes debot action.    # Calls debot engine referenced by debot handle to execute input action.
    # Calls Debot Browser Callbacks if needed.
    # # RemarksChain of actions can be executed if input action generates a list of subactions.
    def execute(payload, &block)
    # INPUT: ParamsOfExecute
    # debot_handle: DebotHandle -     #     # Debot handle which references an instance of debot engine.
    # action: DebotAction -     #     # Debot Action that must be executed.
```
```ruby
    # [UNSTABLE](UNSTABLE.md) Sends message to Debot.    # Used by Debot Browser to send response on Dinterface call or from other Debots.
    def send(payload, &block)
    # INPUT: ParamsOfSend
    # debot_handle: DebotHandle -     #     # Debot handle which references an instance of debot engine.
    # message: String -     #     # BOC of internal message to debot encoded in base64 format.
```
```ruby
    # [UNSTABLE](UNSTABLE.md) Destroys debot handle.    # Removes handle from Client Context and drops debot engine referenced by that handle.
    def remove(payload, &block)
    # INPUT: ParamsOfRemove
    # debot_handle: DebotHandle -     #     # Debot handle which references an instance of debot engine.
```
</details>

<details>
  <summary>PROOFS</summary>

```ruby
    # Proves that a given block's data, which is queried from TONOS API, can be trusted.    # This function checks block proofs and compares given data with the proven.
    # If the given data differs from the proven, the exception will be thrown.
    # The input param is a single block's JSON object, which was queried from DApp server usingfunctions such as `net.query`, `net.query_collection` or `net.wait_for_collection`.
    # If block's BOC is not provided in the JSON, it will be queried from DApp server(in this case it is required to provide at least `id` of block).
    # Please note, that joins (like `signatures` in `Block`) are separated entities and not supported,so function will throw an exception in a case if JSON being checked has such entities in it.
    # If `cache_in_local_storage` in config is set to `true` (default), downloaded proofs andmaster-chain BOCs are saved into the persistent local storage (e.g. file system for nativeenvironments or browser's IndexedDB for the web); otherwise all the data is cached only inmemory in current client's context and will be lost after destruction of the client.
    # **Why Proofs are needed**Proofs are needed to ensure that the data downloaded from a DApp server is real blockchaindata. Checking proofs can protect from the malicious DApp server which can potentially providefake data, or also from "Man in the Middle" attacks class.
    # **What Proofs are**Simply, proof is a list of signatures of validators', which have signed this particular master-block.
    # The very first validator set's public keys are included in the zero-state. Whe know a root hashof the zero-state, because it is stored in the network configuration file, it is our authorityroot. For proving zero-state it is enough to calculate and compare its root hash.
    # In each new validator cycle the validator set is changed. The new one is stored in a key-block,which is signed by the validator set, which we already trust, the next validator set will bestored to the new key-block and signed by the current validator set, and so on.
    # In order to prove any block in the master-chain we need to check, that it has been signed bya trusted validator set. So we need to check all key-blocks' proofs, started from the zero-stateand until the block, which we want to prove. But it can take a lot of time and traffic todownload and prove all key-blocks on a client. For solving this, special trusted blocks are usedin Ever-SDK.
    # The trusted block is the authority root, as well, as the zero-state. Each trusted block is the`id` (e.g. `root_hash`) of the already proven key-block. There can be plenty of trustedblocks, so there can be a lot of authority roots. The hashes of trusted blocks for MainNetand DevNet are hardcoded in SDK in a separated binary file (trusted_key_blocks.bin) and isbeing updated for each release by using `update_trusted_blocks` utility.
    # See [update_trusted_blocks](../../../tools/update_trusted_blocks) directory for more info.
    # In future SDK releases, one will also be able to provide their hashes of trusted blocks forother networks, besides for MainNet and DevNet.
    # By using trusted key-blocks, in order to prove any block, we can prove chain of key-blocks tothe closest previous trusted key-block, not only to the zero-state.
    # But shard-blocks don't have proofs on DApp server. In this case, in order to prove any shard-block data, we search for a corresponding master-block, which contains the root hash of thisshard-block, or some shard block which is linked to that block in shard-chain. After provingthis master-block, we traverse through each link and calculate and compare hashes with links,one-by-one. After that we can ensure that this shard-block has also been proven.
    def proof_block_data(payload, &block)
    # INPUT: ParamsOfProofBlockData
    # block: Value -     #     # Single block's data, retrieved from TONOS API, that needs proof. Required fields are `id` and/or top-level `boc` (for block identification), others are optional.
```
```ruby
    # Proves that a given transaction's data, which is queried from TONOS API, can be trusted.    # This function requests the corresponding block, checks block proofs, ensures that giventransaction exists in the proven block and compares given data with the proven.
    # If the given data differs from the proven, the exception will be thrown.
    # The input parameter is a single transaction's JSON object (see params description),which was queried from TONOS API using functions such as `net.query`, `net.query_collection`or `net.wait_for_collection`.
    # If transaction's BOC and/or `block_id` are not provided in the JSON, they will be queried fromTONOS API.
    # Please note, that joins (like `account`, `in_message`, `out_messages`, etc. in `Transaction`entity) are separated entities and not supported, so function will throw an exception in a caseif JSON being checked has such entities in it.
    # For more information about proofs checking, see description of `proof_block_data` function.
    def proof_transaction_data(payload, &block)
    # INPUT: ParamsOfProofTransactionData
    # transaction: Value -     #     # Single transaction's data as queried from DApp server, without modifications. The required fields are `id` and/or top-level `boc`, others are optional. In order to reduce network requests count, it is recommended to provide `block_id` and `boc` of transaction.
```
```ruby
    # Proves that a given message's data, which is queried from TONOS API, can be trusted.    # This function first proves the corresponding transaction, ensures that the proven transactionrefers to the given message and compares given data with the proven.
    # If the given data differs from the proven, the exception will be thrown.
    # The input parameter is a single message's JSON object (see params description),which was queried from TONOS API using functions such as `net.query`, `net.query_collection`or `net.wait_for_collection`.
    # If message's BOC and/or non-null `src_transaction.id` or `dst_transaction.id` are not providedin the JSON, they will be queried from TONOS API.
    # Please note, that joins (like `block`, `dst_account`, `dst_transaction`, `src_account`,`src_transaction`, etc. in `Message` entity) are separated entities and not supported,so function will throw an exception in a case if JSON being checked has such entities in it.
    # For more information about proofs checking, see description of `proof_block_data` function.
    def proof_message_data(payload, &block)
    # INPUT: ParamsOfProofMessageData
    # message: Value -     #     # Single message's data as queried from DApp server, without modifications. The required fields are `id` and/or top-level `boc`, others are optional. In order to reduce network requests count, it is recommended to provide at least `boc` of message and non-null `src_transaction.id` or `dst_transaction.id`.
```
</details>



## Tests

1. create __.env.test__ file inside root directory of this library with variables   

example for NodeSE   
```
spec_ffi=./TON-SDK/target/release/libton_client.dylib
server_address=http://localhost:80
giver_abi_name=GiverNodeSE
giver_amount=10000000000
```
2. Run tests: inside folder of this library execute this commands      
**rspec spec/binding.rb**   
**rspec spec/client.rb**  
**rspec spec/context.rb**  
**rspec spec/abi.rb**   
**rspec spec/boc.rb**   
**rspec spec/crypto.rb**   
**rspec spec/net.rb**   
**rspec spec/processing.rb**   
**rspec spec/tvm.rb**   
**rspec spec/utils.rb**


## Update


```

ton-client-ruby update
 
```


or

 
```

curl https://raw.githubusercontent.com/tonlabs/TON-SDK/master/tools/api.json > api.json


```


```

ton-client-ruby update ./api.json

```

or

 
```

cd ton-client-ruby

```


```

./bin/ton-client-ruby update

```
 
