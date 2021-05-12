module TonClient

  class Abi
    include CommonInstanceHelpers

    attr_reader :core, :context
    MODULE = self.to_s.downcase.gsub(/^(.+::|)(\w+)$/, '\2').freeze

    def initialize(context: Context.new, core: TonClient::TonBinding)
      @context = context
      @core = core
    end

    # INPUT: TSDKParamsOfEncodeMessageBody
    # abi: TSDKAbi -     # Contract ABI.
    # call_set: TSDKCallSet -     # Function call parameters.    # Must be specified in non deploy message.In case of deploy message contains parameters of constructor.
    # is_internal: Boolean -     # True if internal message body must be encoded.
    # signer: TSDKSigner -     # Signing parameters.
    # processing_try_index: Number -     # Processing try index.    # Used in message processing with retries.Encoder uses the provided try index to calculate messageexpiration time.Expiration timeouts will grow with every retry.Default value is 0.
    # RESPONSE: TSDKResultOfEncodeMessageBody
    # body: String -     # Message body BOC encoded with `base64`.
    # data_to_sign: String -     # Optional data to sign.    # Encoded with `base64`. Presents when `message` is unsigned. Can be used for externalmessage signing. Is this case you need to sing this data andproduce signed message using `abi.attach_signature`.
    def encode_message_body(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: TSDKParamsOfAttachSignatureToMessageBody
    # abi: TSDKAbi -     # Contract ABI
    # public_key: String -     # Public key.    # Must be encoded with `hex`.
    # message: String -     # Unsigned message body BOC.    # Must be encoded with `base64`.
    # signature: String -     # Signature.    # Must be encoded with `hex`.
    # RESPONSE: TSDKResultOfAttachSignatureToMessageBody
    # body: String - 
    def attach_signature_to_message_body(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: TSDKParamsOfEncodeMessage
    # abi: TSDKAbi -     # Contract ABI.
    # address: String -     # Target address the message will be sent to.    # Must be specified in case of non-deploy message.
    # deploy_set: TSDKDeploySet -     # Deploy parameters.    # Must be specified in case of deploy message.
    # call_set: TSDKCallSet -     # Function call parameters.    # Must be specified in case of non-deploy message.In case of deploy message it is optional and contains parametersof the functions that will to be called upon deploy transaction.
    # signer: TSDKSigner -     # Signing parameters.
    # processing_try_index: Number -     # Processing try index.    # Used in message processing with retries (if contract's ABI includes "expire" header).Encoder uses the provided try index to calculate messageexpiration time. The 1st message expiration time is specified inClient config.Expiration timeouts will grow with every retry.Retry grow factor is set in Client config:<.....add config parameter with default value here>Default value is 0.
    # RESPONSE: TSDKResultOfEncodeMessage
    # message: String -     # Message BOC encoded with `base64`.
    # data_to_sign: String -     # Optional data to be signed encoded in `base64`.    # Returned in case of `Signer::External`. Can be used for externalmessage signing. Is this case you need to use this data to create signature andthen produce signed message using `abi.attach_signature`.
    # address: String -     # Destination address.
    # message_id: String -     # Message id.
    def encode_message(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: TSDKParamsOfEncodeInternalMessage
    # abi: TSDKAbi -     # Contract ABI.    # Can be None if both deploy_set and call_set are None.
    # address: String -     # Target address the message will be sent to.    # Must be specified in case of non-deploy message.
    # src_address: String -     # Source address of the message.
    # deploy_set: TSDKDeploySet -     # Deploy parameters.    # Must be specified in case of deploy message.
    # call_set: TSDKCallSet -     # Function call parameters.    # Must be specified in case of non-deploy message.In case of deploy message it is optional and contains parametersof the functions that will to be called upon deploy transaction.
    # value: String -     # Value in nanotokens to be sent with message.
    # bounce: Boolean -     # Flag of bounceable message.    # Default is true.
    # enable_ihr: Boolean -     # Enable Instant Hypercube Routing for the message.    # Default is false.
    # RESPONSE: TSDKResultOfEncodeInternalMessage
    # message: String -     # Message BOC encoded with `base64`.
    # address: String -     # Destination address.
    # message_id: String -     # Message id.
    def encode_internal_message(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: TSDKParamsOfAttachSignature
    # abi: TSDKAbi -     # Contract ABI
    # public_key: String -     # Public key encoded in `hex`.
    # message: String -     # Unsigned message BOC encoded in `base64`.
    # signature: String -     # Signature encoded in `hex`.
    # RESPONSE: TSDKResultOfAttachSignature
    # message: String -     # Signed message BOC
    # message_id: String -     # Message ID
    def attach_signature(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: TSDKParamsOfDecodeMessage
    # abi: TSDKAbi -     # contract ABI
    # message: String -     # Message BOC
    # RESPONSE: TSDKDecodedMessageBody
    # body_type: TSDKMessageBodyType -     # Type of the message body content.
    # name: String -     # Function or event name.
    # value: Value -     # Parameters or result value.
    # header: TSDKFunctionHeader -     # Function header.
    def decode_message(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: TSDKParamsOfDecodeMessageBody
    # abi: TSDKAbi -     # Contract ABI used to decode.
    # body: String -     # Message body BOC encoded in `base64`.
    # is_internal: Boolean -     # True if the body belongs to the internal message.
    # RESPONSE: TSDKDecodedMessageBody
    # body_type: TSDKMessageBodyType -     # Type of the message body content.
    # name: String -     # Function or event name.
    # value: Value -     # Parameters or result value.
    # header: TSDKFunctionHeader -     # Function header.
    def decode_message_body(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: TSDKParamsOfEncodeAccount
    # state_init: TSDKStateInitSource -     # Source of the account state init.
    # balance: BigInt -     # Initial balance.
    # last_trans_lt: BigInt -     # Initial value for the `last_trans_lt`.
    # last_paid: Number -     # Initial value for the `last_paid`.
    # boc_cache: TSDKBocCacheType -     # Cache type to put the result.    # The BOC itself returned if no cache type provided
    # RESPONSE: TSDKResultOfEncodeAccount
    # account: String -     # Account BOC encoded in `base64`.
    # id: String -     # Account ID  encoded in `hex`.
    def encode_account(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

  end
end

