
# Ruby Client for Free TON SDK

[![GEM](https://img.shields.io/badge/ruby-gem-green)]()

## Install

Install gem
```bash
gem install ton-client-ruby
```

Install TON-SDK
```bash
ton-client-ruby setup
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


#### ClientErrorCode

case NotImplemented: 1
case InvalidHex: 2
case InvalidBase64: 3
case InvalidAddress: 4
case CallbackParamsCantBeConvertedToJson: 5
case WebsocketConnectError: 6
case WebsocketReceiveError: 7
case WebsocketSendError: 8
case HttpClientCreateError: 9
case HttpRequestCreateError: 10
case HttpRequestSendError: 11
case HttpRequestParseError: 12
case CallbackNotRegistered: 13
case NetModuleNotInit: 14
case InvalidConfig: 15
case CannotCreateRuntime: 16
case InvalidContextHandle: 17
case CannotSerializeResult: 18
case CannotSerializeError: 19
case CannotConvertJsValueToJson: 20
case CannotReceiveSpawnedResult: 21
case SetTimerError: 22
case InvalidParams: 23
case ContractsAddressConversionFailed: 24
case UnknownFunction: 25
case AppRequestError: 26
case NoSuchRequest: 27
case CanNotSendRequestResult: 28
case CanNotReceiveRequestResult: 29
case CanNotParseRequestResult: 30
case UnexpectedCallbackResponse: 31
case CanNotParseNumber: 32
case InternalError: 33

#### AppRequestResult

case Error: Error
case Ok: Ok

#### CryptoErrorCode

case InvalidPublicKey: 100
case InvalidSecretKey: 101
case InvalidKey: 102
case InvalidFactorizeChallenge: 106
case InvalidBigInt: 107
case ScryptFailed: 108
case InvalidKeySize: 109
case NaclSecretBoxFailed: 110
case NaclBoxFailed: 111
case NaclSignFailed: 112
case Bip39InvalidEntropy: 113
case Bip39InvalidPhrase: 114
case Bip32InvalidKey: 115
case Bip32InvalidDerivePath: 116
case Bip39InvalidDictionary: 117
case Bip39InvalidWordCount: 118
case MnemonicGenerationFailed: 119
case MnemonicFromEntropyFailed: 120
case SigningBoxNotRegistered: 121
case InvalidSignature: 122

#### ParamsOfAppSigningBox

case GetPublicKey: GetPublicKey
case Sign: Sign

#### ResultOfAppSigningBox

case GetPublicKey: GetPublicKey
case Sign: Sign

#### AbiErrorCode

case RequiredAddressMissingForEncodeMessage: 301
case RequiredCallSetMissingForEncodeMessage: 302
case InvalidJson: 303
case InvalidMessage: 304
case EncodeDeployMessageFailed: 305
case EncodeRunMessageFailed: 306
case AttachSignatureFailed: 307
case InvalidTvcImage: 308
case RequiredPublicKeyMissingForFunctionHeader: 309
case InvalidSigner: 310
case InvalidAbi: 311
case InvalidFunctionId: 312

#### Abi

case Contract: Contract
case Json: Json
case Handle: Handle
case Serialized: Serialized

#### Signer

case None: None
case External: External
case Keys: Keys
case SigningBox: SigningBox

#### MessageBodyType

case Input: 
case Output: 
case InternalOutput: 
case Event: 

#### StateInitSource

case Message: Message
case StateInit: StateInit
case Tvc: Tvc

#### MessageSource

case Encoded: Encoded
case EncodingParams: EncodingParams

#### BocCacheType

case Pinned: Pinned
case Unpinned: Unpinned

#### BocErrorCode

case InvalidBoc: 201
case SerializationError: 202
case InappropriateBlock: 203
case MissingSourceBoc: 204
case InsufficientCacheSize: 205
case BocRefNotFound: 206
case InvalidBocRef: 207

#### BuilderOp

case Integer: Integer
case BitString: BitString
case Cell: Cell
case CellBoc: CellBoc

#### ProcessingErrorCode

case MessageAlreadyExpired: 501
case MessageHasNotDestinationAddress: 502
case CanNotBuildMessageCell: 503
case FetchBlockFailed: 504
case SendMessageFailed: 505
case InvalidMessageBoc: 506
case MessageExpired: 507
case TransactionWaitTimeout: 508
case InvalidBlockReceived: 509
case CanNotCheckBlockShard: 510
case BlockNotFound: 511
case InvalidData: 512
case ExternalSignerMustNotBeUsed: 513

#### ProcessingEvent

case WillFetchFirstBlock: WillFetchFirstBlock
case FetchFirstBlockFailed: FetchFirstBlockFailed
case WillSend: WillSend
case DidSend: DidSend
case SendFailed: SendFailed
case WillFetchNextBlock: WillFetchNextBlock
case FetchNextBlockFailed: FetchNextBlockFailed
case MessageExpired: MessageExpired

#### AddressStringFormat

case AccountId: AccountId
case Hex: Hex
case Base64: Base64

#### TvmErrorCode

case CanNotReadTransaction: 401
case CanNotReadBlockchainConfig: 402
case TransactionAborted: 403
case InternalError: 404
case ActionPhaseFailed: 405
case AccountCodeMissing: 406
case LowBalance: 407
case AccountFrozenOrDeleted: 408
case AccountMissing: 409
case UnknownExecutionError: 410
case InvalidInputStack: 411
case InvalidAccountBoc: 412
case InvalidMessageType: 413
case ContractExecutionError: 414

#### AccountForExecutor

case None: None
case Uninit: Uninit
case Account: Account

#### NetErrorCode

case QueryFailed: 601
case SubscribeFailed: 602
case WaitForFailed: 603
case GetSubscriptionResultFailed: 604
case InvalidServerResponse: 605
case ClockOutOfSync: 606
case WaitForTimeout: 607
case GraphqlError: 608
case NetworkModuleSuspended: 609
case WebsocketDisconnected: 610
case NotSupported: 611
case NoEndpointsProvided: 612
case GraphqlWebsocketInitError: 613
case NetworkModuleResumed: 614

#### SortDirection

case ASC: 
case DESC: 

#### ParamsOfQueryOperation

case QueryCollection: QueryCollection
case WaitForCollection: WaitForCollection
case AggregateCollection: AggregateCollection
case QueryCounterparties: QueryCounterparties

#### AggregationFn

case COUNT: 
case MIN: 
case MAX: 
case SUM: 
case AVERAGE: 

#### DebotErrorCode

case DebotStartFailed: 801
case DebotFetchFailed: 802
case DebotExecutionFailed: 803
case DebotInvalidHandle: 804
case DebotInvalidJsonParams: 805
case DebotInvalidFunctionId: 806
case DebotInvalidAbi: 807
case DebotGetMethodFailed: 808
case DebotInvalidMsg: 809
case DebotExternalCallFailed: 810
case DebotBrowserCallbackFailed: 811
case DebotOperationRejected: 812

#### DebotActivity

case Transaction: Transaction

#### ParamsOfAppDebotBrowser

case Log: Log
case Switch: Switch
case SwitchCompleted: SwitchCompleted
case ShowAction: ShowAction
case Input: Input
case GetSigningBox: GetSigningBox
case InvokeDebot: InvokeDebot
case Send: Send
case Approve: Approve

#### ResultOfAppDebotBrowser

case Input: Input
case GetSigningBox: GetSigningBox
case InvokeDebot: InvokeDebot
case Approve: Approve
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
    # Performs prime factorization – decomposition of a composite number into a product of smaller prime integers (factors). See [https://en.wikipedia.org/wiki/Integer_factorization]
    def factorize(payload, &block)
    # INPUT: ParamsOfFactorize
    # composite: String -     #     # Hexadecimal representation of u64 composite number.

    # RESPONSE: ResultOfFactorize
    # factors: Array -     #     # Two factors of composite or empty if composite can't be factorized.
```
```ruby
    # Performs modular exponentiation for big integers (`base`^`exponent` mod `modulus`). See [https://en.wikipedia.org/wiki/Modular_exponentiation]
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
    # Derives key from `password` and `key` using `scrypt` algorithm. See [https://en.wikipedia.org/wiki/Scrypt].    # # Arguments- `log_n` - The log2 of the Scrypt parameter `N`- `r` - The Scrypt parameter `r`- `p` - The Scrypt parameter `p`# Conditions- `log_n` must be less than `64`- `r` must be greater than `0` and less than or equal to `4294967295`- `p` must be greater than `0` and less than `4294967295`# Recommended values sufficient for most use-cases- `log_n = 15` (`n = 32768`)- `r = 8`- `p = 1`
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
    # Generates a key pair for signing from the secret key
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
    # secret: String -     #     # Signer's secret key - unprefixed 0-padded to 64 symbols hex string

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
    # secret: String -     #     # Signer's secret key - unprefixed 0-padded to 64 symbols hex string

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
    # nonce: String - 
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
    # key: String -     #     # Public key - unprefixed 0-padded to 64 symbols hex string

    # RESPONSE: ResultOfNaclBoxOpen
    # decrypted: String -     #     # Decrypted data encoded in `base64`.
```
```ruby
    # Prints the list of words from the specified dictionary
    def mnemonic_words(payload, &block)
    # INPUT: ParamsOfMnemonicWords
    # dictionary: TSDKMnemonicDictionary -     #     # Dictionary identifier

    # RESPONSE: ResultOfMnemonicWords
    # words: String -     #     # The list of mnemonic words
```
```ruby
    # Generates a random mnemonic from the specified dictionary and word count
    def mnemonic_from_random(payload, &block)
    # INPUT: ParamsOfMnemonicFromRandom
    # dictionary: TSDKMnemonicDictionary -     #     # Dictionary identifier
    # word_count: Number<Optional> -     #     # Mnemonic word count

    # RESPONSE: ResultOfMnemonicFromRandom
    # phrase: String -     #     # String of mnemonic words
```
```ruby
    # Generates mnemonic from pre-generated entropy
    def mnemonic_from_entropy(payload, &block)
    # INPUT: ParamsOfMnemonicFromEntropy
    # entropy: String -     #     # Entropy bytes.    #     # Hex encoded.
    # dictionary: TSDKMnemonicDictionary -     #     # Dictionary identifier
    # word_count: Number<Optional> -     #     # Mnemonic word count

    # RESPONSE: ResultOfMnemonicFromEntropy
    # phrase: String -     #     # Phrase
```
```ruby
    # The phrase supplied will be checked for word length and validated according to the checksum specified in BIP0039.
    def mnemonic_verify(payload, &block)
    # INPUT: ParamsOfMnemonicVerify
    # phrase: String -     #     # Phrase
    # dictionary: TSDKMnemonicDictionary -     #     # Dictionary identifier
    # word_count: Number<Optional> -     #     # Word count

    # RESPONSE: ResultOfMnemonicVerify
    # valid: Boolean -     #     # Flag indicating if the mnemonic is valid or not
```
```ruby
    # Validates the seed phrase, generates master key and then derives the key pair from the master key and the specified path
    def mnemonic_derive_sign_keys(payload, &block)
    # INPUT: ParamsOfMnemonicDeriveSignKeys
    # phrase: String -     #     # Phrase
    # path: String<Optional> -     #     # Derivation path, for instance "m/44'/396'/0'/0/0"
    # dictionary: TSDKMnemonicDictionary -     #     # Dictionary identifier
    # word_count: Number<Optional> -     #     # Word count

    # RESPONSE: KeyPair
    # public: String -     #     # Public key - 64 symbols hex string
    # secret: String -     #     # Private key - u64 symbols hex string
```
```ruby
    # Generates an extended master private key that will be the root for all the derived keys
    def hdkey_xprv_from_mnemonic(payload, &block)
    # INPUT: ParamsOfHDKeyXPrvFromMnemonic
    # phrase: String -     #     # String with seed phrase
    # dictionary: TSDKMnemonicDictionary -     #     # Dictionary identifier
    # word_count: Number<Optional> -     #     # Mnemonic word count

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
</details>

<details>
  <summary>ABI</summary>

```ruby
    # Encodes message body according to ABI function call.
    def encode_message_body(payload, &block)
    # INPUT: ParamsOfEncodeMessageBody
    # abi: Abi -     #     # Contract ABI.
    # call_set: CallSet -     #     # Function call parameters.    #     # Must be specified in non deploy message.
    #     # In case of deploy message contains parameters of constructor.
    # is_internal: Boolean -     #     # True if internal message body must be encoded.
    # signer: Signer -     #     # Signing parameters.
    # processing_try_index: Number<Optional> -     #     # Processing try index.    #     # Used in message processing with retries.
    #     # Encoder uses the provided try index to calculate messageexpiration time.
    #     # Expiration timeouts will grow with every retry.
    #     # Default value is 0.

    # RESPONSE: ResultOfEncodeMessageBody
    # body: String -     #     # Message body BOC encoded with `base64`.
    # data_to_sign: String<Optional> -     #     # Optional data to sign.    #     # Encoded with `base64`.
    #     # # Presents when `message` is unsigned. Can be used for externalmessage signing. Is this case you need to sing this data andproduce signed message using `abi.attach_signature`.
```
```ruby

    def attach_signature_to_message_body(payload, &block)
    # INPUT: ParamsOfAttachSignatureToMessageBody
    # abi: Abi -     #     # Contract ABI
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
    # abi: Abi -     #     # Contract ABI.
    # address: String<Optional> -     #     # Target address the message will be sent to.    #     # Must be specified in case of non-deploy message.
    # deploy_set: DeploySet<Optional> -     #     # Deploy parameters.    #     # Must be specified in case of deploy message.
    # call_set: CallSet<Optional> -     #     # Function call parameters.    #     # Must be specified in case of non-deploy message.
    #     # In case of deploy message it is optional and contains parametersof the functions that will to be called upon deploy transaction.
    # signer: Signer -     #     # Signing parameters.
    # processing_try_index: Number<Optional> -     #     # Processing try index.    #     # Used in message processing with retries (if contract's ABI includes "expire" header).
    #     # Encoder uses the provided try index to calculate messageexpiration time. The 1st message expiration time is specified inClient config.
    #     # Expiration timeouts will grow with every retry.
    #     # Retry grow factor is set in Client config:
    #     # <.....add config parameter with default value here>Default value is 0.

    # RESPONSE: ResultOfEncodeMessage
    # message: String -     #     # Message BOC encoded with `base64`.
    # data_to_sign: String<Optional> -     #     # Optional data to be signed encoded in `base64`.    #     # Returned in case of `Signer::External`. Can be used for externalmessage signing. Is this case you need to use this data to create signature andthen produce signed message using `abi.attach_signature`.
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
    # abi: Abi<Optional> -     #     # Contract ABI.    #     # Can be None if both deploy_set and call_set are None.
    # address: String<Optional> -     #     # Target address the message will be sent to.    #     # Must be specified in case of non-deploy message.
    # src_address: String<Optional> -     #     # Source address of the message.
    # deploy_set: DeploySet<Optional> -     #     # Deploy parameters.    #     # Must be specified in case of deploy message.
    # call_set: CallSet<Optional> -     #     # Function call parameters.    #     # Must be specified in case of non-deploy message.
    #     # In case of deploy message it is optional and contains parametersof the functions that will to be called upon deploy transaction.
    # value: String -     #     # Value in nanotokens to be sent with message.
    # bounce: Boolean<Optional> -     #     # Flag of bounceable message.    #     # Default is true.
    # enable_ihr: Boolean<Optional> -     #     # Enable Instant Hypercube Routing for the message.    #     # Default is false.

    # RESPONSE: ResultOfEncodeInternalMessage
    # message: String -     #     # Message BOC encoded with `base64`.
    # address: String -     #     # Destination address.
    # message_id: String -     #     # Message id.
```
```ruby
    # Combines `hex`-encoded `signature` with `base64`-encoded `unsigned_message`. Returns signed message encoded in `base64`.
    def attach_signature(payload, &block)
    # INPUT: ParamsOfAttachSignature
    # abi: Abi -     #     # Contract ABI
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
    # abi: Abi -     #     # contract ABI
    # message: String -     #     # Message BOC

    # RESPONSE: DecodedMessageBody
    # body_type: MessageBodyType -     #     # Type of the message body content.
    # name: String -     #     # Function or event name.
    # value: Value<Optional> -     #     # Parameters or result value.
    # header: FunctionHeader<Optional> -     #     # Function header.
```
```ruby
    # Decodes message body using provided body BOC and ABI.
    def decode_message_body(payload, &block)
    # INPUT: ParamsOfDecodeMessageBody
    # abi: Abi -     #     # Contract ABI used to decode.
    # body: String -     #     # Message body BOC encoded in `base64`.
    # is_internal: Boolean -     #     # True if the body belongs to the internal message.

    # RESPONSE: DecodedMessageBody
    # body_type: MessageBodyType -     #     # Type of the message body content.
    # name: String -     #     # Function or event name.
    # value: Value<Optional> -     #     # Parameters or result value.
    # header: FunctionHeader<Optional> -     #     # Function header.
```
```ruby
    # Creates account state BOC    # Creates account state provided with one of these sets of data :
    # 1. BOC of code, BOC of data, BOC of library2. TVC (string in `base64`), keys, init params
    def encode_account(payload, &block)
    # INPUT: ParamsOfEncodeAccount
    # state_init: StateInitSource -     #     # Source of the account state init.
    # balance: BigInt<Optional> -     #     # Initial balance.
    # last_trans_lt: BigInt<Optional> -     #     # Initial value for the `last_trans_lt`.
    # last_paid: Number<Optional> -     #     # Initial value for the `last_paid`.
    # boc_cache: BocCacheType<Optional> -     #     # Cache type to put the result.    #     # The BOC itself returned if no cache type provided

    # RESPONSE: ResultOfEncodeAccount
    # account: String -     #     # Account BOC encoded in `base64`.
    # id: String -     #     # Account ID  encoded in `hex`.
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
    # boc: String -     #     # BOC encoded as base64

    # RESPONSE: ResultOfGetBocHash
    # hash: String -     #     # BOC root hash encoded with hex
```
```ruby
    # Extracts code from TVC contract image
    def get_code_from_tvc(payload, &block)
    # INPUT: ParamsOfGetCodeFromTvc
    # tvc: String -     #     # Contract TVC image encoded as base64

    # RESPONSE: ResultOfGetCodeFromTvc
    # code: String -     #     # Contract code encoded as base64
```
```ruby
    # Get BOC from cache
    def cache_get(payload, &block)
    # INPUT: ParamsOfBocCacheGet
    # boc_ref: String -     #     # Reference to the cached BOC

    # RESPONSE: ResultOfBocCacheGet
    # boc: String<Optional> -     #     # BOC encoded as base64.
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
    # boc_ref: String<Optional> -     #     # Reference to the cached BOC.    #     # If it is provided then only referenced BOC is unpinned
```
```ruby
    # Encodes BOC from builder operations.
    def encode_boc(payload, &block)
    # INPUT: ParamsOfEncodeBoc
    # builder: Array -     #     # Cell builder operations.
    # boc_cache: BocCacheType<Optional> -     #     # Cache type to put the result. The BOC itself returned if no cache type provided.

    # RESPONSE: ResultOfEncodeBoc
    # boc: String -     #     # Encoded cell BOC or BOC cache key.
```
</details>

<details>
  <summary>PROCESSING</summary>

```ruby
    # Sends message to the network    # Sends message to the network and returns the last generated shard block of the destination accountbefore the message was sent. It will be required later for message processing.
    def send_message(payload, &block)
    # INPUT: ParamsOfSendMessage
    # message: String -     #     # Message BOC.
    # abi: Abi<Optional> -     #     # Optional message ABI.    #     # If this parameter is specified and the message has the`expire` header then expiration time will be checked againstthe current time to prevent unnecessary sending of already expired message.
    #     # The `message already expired` error will be returned in thiscase.
    #     # Note, that specifying `abi` for ABI compliant contracts isstrongly recommended, so that proper processing strategy can bechosen.
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
    # abi: Abi<Optional> -     #     # Optional ABI for decoding the transaction result.    #     # If it is specified, then the output messages' bodies will bedecoded according to this ABI.
    #     # The `abi_decoded` result field will be filled out.
    # message: String -     #     # Message BOC.    #     # Encoded with `base64`.
    # shard_block_id: String -     #     # The last generated block id of the destination account shard before the message was sent.    #     # You must provide the same value as the `send_message` has returned.
    # send_events: Boolean -     #     # Flag that enables/disables intermediate events
    # sending_endpoints: Array<Optional> -     #     # The list of endpoints to which the message was sent.    #     # You must provide the same value as the `send_message` has returned.

    # RESPONSE: ResultOfProcessMessage
    # transaction: Value -     #     # Parsed transaction.    #     # In addition to the regular transaction fields there is a`boc` field encoded with `base64` which contains sourcetransaction BOC.
    # out_messages: Array -     #     # List of output messages' BOCs.    #     # Encoded as `base64`
    # decoded: DecodedOutput<Optional> -     #     # Optional decoded message bodies according to the optional `abi` parameter.
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
    # decoded: DecodedOutput<Optional> -     #     # Optional decoded message bodies according to the optional `abi` parameter.
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
    # level: Number<Optional> -     #     # Compression level, from 1 to 21. Where: 1 - lowest compression level (fastest compression); 21 - highest compression level (slowest compression). If level is omitted, the default compression level is used (currently `3`).

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
    # Can be used for contract debugginh, to find out the reason why message was not delivered successfully - because Validators just throw away the failed external inbound messages, here you can catch them.
    # Another use case is to estimate fees for message execution. Set  `AccountForExecutor::Account.unlimited_balance`to `true` so that emulation will not depend on the actual balance.
    # One more use case - you can produce the sequence of operations,thus emulating the multiple contract calls locally.
    # And so on.
    # To get the account BOC (bag of cells) - use `net.query` method to download it from GraphQL API(field `boc` of `account`) or generate it with `abi.encode_account` method.
    # To get the message BOC - use `abi.encode_message` or prepare it any other way, for instance, with FIFT script.
    # If you need this emulation to be as precise as possible then specify `ParamsOfRunExecutor` parameter.
    # If you need to see the aborted transaction as a result, not as an error, set `skip_transaction_check` to `true`.
    def run_executor(payload, &block)
    # INPUT: ParamsOfRunExecutor
    # message: String -     #     # Input message BOC.    #     # Must be encoded as base64.
    # account: AccountForExecutor -     #     # Account to run on executor
    # execution_options: ExecutionOptions<Optional> -     #     # Execution options.
    # abi: Abi<Optional> -     #     # Contract ABI for decoding output messages
    # skip_transaction_check: Boolean<Optional> -     #     # Skip transaction check flag
    # boc_cache: BocCacheType<Optional> -     #     # Cache type to put the result.    #     # The BOC itself returned if no cache type provided
    # return_updated_account: Boolean<Optional> -     #     # Return updated account flag.    #     # Empty string is returned if the flag is `false`

    # RESPONSE: ResultOfRunExecutor
    # transaction: Value -     #     # Parsed transaction.    #     # In addition to the regular transaction fields there is a`boc` field encoded with `base64` which contains sourcetransaction BOC.
    # out_messages: Array -     #     # List of output messages' BOCs.    #     # Encoded as `base64`
    # decoded: DecodedOutput<Optional> -     #     # Optional decoded message bodies according to the optional `abi` parameter.
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
    # execution_options: ExecutionOptions<Optional> -     #     # Execution options.
    # abi: Abi<Optional> -     #     # Contract ABI for decoding output messages
    # boc_cache: BocCacheType<Optional> -     #     # Cache type to put the result.    #     # The BOC itself returned if no cache type provided
    # return_updated_account: Boolean<Optional> -     #     # Return updated account flag.    #     # Empty string is returned if the flag is `false`

    # RESPONSE: ResultOfRunTvm
    # out_messages: Array -     #     # List of output messages' BOCs.    #     # Encoded as `base64`
    # decoded: DecodedOutput<Optional> -     #     # Optional decoded message bodies according to the optional `abi` parameter.
    # account: String -     #     # Updated account state BOC.    #     # Encoded as `base64`. Attention! Only `account_state.storage.state.data` part of the BOC is updated.
```
```ruby
    # Executes a get-method of FIFT contract    # Executes a get-method of FIFT contract that fulfills the smc-guidelines https://test.ton.org/smc-guidelines.txtand returns the result data from TVM's stack
    def run_get(payload, &block)
    # INPUT: ParamsOfRunGet
    # account: String -     #     # Account BOC in `base64`
    # function_name: String -     #     # Function name
    # input: Value -     #     # Input parameters
    # execution_options: ExecutionOptions<Optional> -     #     # Execution options
    # tuple_list_as_array: Boolean<Optional> -     #     # Convert lists based on nested tuples in the **result** into plain arrays.    #     # Default is `false`. Input parameters may use any of lists representationsIf you receive this error on Web: "Runtime error. Unreachable code should not be executed...",set this flag to true.
    #     # This may happen, for example, when elector contract contains too many participants

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
    # order: Array<Optional> -     #     # Sorting order
    # limit: Number<Optional> -     #     # Number of documents to return

    # RESPONSE: ResultOfQueryCollection
    # result: Array -     #     # Objects that match the provided criteria
```
```ruby
    # Aggregates collection data.    # Aggregates values from the specified `fields` for recordsthat satisfies the `filter` conditions,
    def aggregate_collection(payload, &block)
    # INPUT: ParamsOfAggregateCollection
    # collection: String -     #     # Collection name (accounts, blocks, transactions, messages, block_signatures)
    # filter: Value -     #     # Collection filter
    # fields: Array<Optional> -     #     # Projection (result) string

    # RESPONSE: ResultOfAggregateCollection
    # values: Value -     #     # Values for requested fields.    #     # Returns an array of strings. Each string refers to the corresponding `fields` item.
    #     # Numeric value is returned as a decimal string representations.
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
    # timeout: Number<Optional> -     #     # Query timeout

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
    # Creates a subscription    # Triggers for each insert/update of data that satisfiesthe `filter` conditions.
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
    # Allows to query and paginate through the list of accounts that the specified account has interacted with, sorted by the time of the last internal message between accounts    # *Attention* this query retrieves data from 'Counterparties' service which is not supported inthe opensource version of DApp Server (and will not be supported) as well as in TON OS SE (will be supported in SE in future),but is always accessible via [TON OS Devnet/Mainnet Clouds](https://docs.ton.dev/86757ecb2/p/85c869-networks)
    def query_counterparties(payload, &block)
    # INPUT: ParamsOfQueryCounterparties
    # account: String -     #     # Account address
    # result: String -     #     # Projection (result) string
    # first: Number<Optional> -     #     # Number of counterparties to return
    # after: String<Optional> -     #     # `cursor` field of the last received result

    # RESPONSE: ResultOfQueryCollection
    # result: Array -     #     # Objects that match the provided criteria
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
