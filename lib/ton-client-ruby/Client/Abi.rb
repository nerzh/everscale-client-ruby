module TonClient

  class Abi
    include CommonInstanceHelpers

    attr_reader :core, :context
    MODULE = self.to_s.downcase.gsub(/^(.+::|)(\w+)$/, '\2').freeze

    def initialize(context: Context.new, core: TonClient::TonBinding)
      @context = context
      @core = core
    end

    # INPUT: ParamsOfEncodeMessageBody
    # abi: Value -     #     # Contract ABI.
    # call_set: CallSet -     #     # Function call parameters.    #     # Must be specified in non deploy message.
    # In case of deploy message contains parameters of constructor.
    # is_internal: Boolean -     #     # True if internal message body must be encoded.
    # signer: Signer -     #     # Signing parameters.
    # processing_try_index: Number<Optional> -     #     # Processing try index.    #     # Used in message processing with retries.
    # Encoder uses the provided try index to calculate messageexpiration time.
    # Expiration timeouts will grow with every retry.
    # Default value is 0.
    # RESPONSE: ResultOfEncodeMessageBody
    # body: String -     #     # Message body BOC encoded with `base64`.
    # data_to_sign: String<Optional> -     #     # Optional data to sign.    #     # Encoded with `base64`.
    # # Presents when `message` is unsigned. Can be used for externalmessage signing. Is this case you need to sing this data andproduce signed message using `abi.attach_signature`.
    def encode_message_body(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfAttachSignatureToMessageBody
    # abi: Value -     #     # Contract ABI
    # public_key: String -     #     # Public key.    #     # Must be encoded with `hex`.
    # message: String -     #     # Unsigned message body BOC.    #     # Must be encoded with `base64`.
    # signature: String -     #     # Signature.    #     # Must be encoded with `hex`.
    # RESPONSE: ResultOfAttachSignatureToMessageBody
    # body: String - 
    def attach_signature_to_message_body(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfEncodeMessage
    # abi: Value -     #     # Contract ABI.
    # address: String<Optional> -     #     # Target address the message will be sent to.    #     # Must be specified in case of non-deploy message.
    # deploy_set: DeploySet<Optional> -     #     # Deploy parameters.    #     # Must be specified in case of deploy message.
    # call_set: CallSet<Optional> -     #     # Function call parameters.    #     # Must be specified in case of non-deploy message.
    # In case of deploy message it is optional and contains parametersof the functions that will to be called upon deploy transaction.
    # signer: Signer -     #     # Signing parameters.
    # processing_try_index: Number<Optional> -     #     # Processing try index.    #     # Used in message processing with retries (if contract's ABI includes "expire" header).
    # Encoder uses the provided try index to calculate messageexpiration time. The 1st message expiration time is specified inClient config.
    # Expiration timeouts will grow with every retry.
    # Retry grow factor is set in Client config:
    # <.....add config parameter with default value here>Default value is 0.
    # RESPONSE: ResultOfEncodeMessage
    # message: String -     #     # Message BOC encoded with `base64`.
    # data_to_sign: String<Optional> -     #     # Optional data to be signed encoded in `base64`.    #     # Returned in case of `Signer::External`. Can be used for externalmessage signing. Is this case you need to use this data to create signature andthen produce signed message using `abi.attach_signature`.
    # address: String -     #     # Destination address.
    # message_id: String -     #     # Message id.
    def encode_message(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfEncodeInternalMessage
    # abi: Value<Optional> -     #     # Contract ABI.    #     # Can be None if both deploy_set and call_set are None.
    # address: String<Optional> -     #     # Target address the message will be sent to.    #     # Must be specified in case of non-deploy message.
    # src_address: String<Optional> -     #     # Source address of the message.
    # deploy_set: DeploySet<Optional> -     #     # Deploy parameters.    #     # Must be specified in case of deploy message.
    # call_set: CallSet<Optional> -     #     # Function call parameters.    #     # Must be specified in case of non-deploy message.
    # In case of deploy message it is optional and contains parametersof the functions that will to be called upon deploy transaction.
    # value: String -     #     # Value in nanotokens to be sent with message.
    # bounce: Boolean<Optional> -     #     # Flag of bounceable message.    #     # Default is true.
    # enable_ihr: Boolean<Optional> -     #     # Enable Instant Hypercube Routing for the message.    #     # Default is false.
    # RESPONSE: ResultOfEncodeInternalMessage
    # message: String -     #     # Message BOC encoded with `base64`.
    # address: String -     #     # Destination address.
    # message_id: String -     #     # Message id.
    def encode_internal_message(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfAttachSignature
    # abi: Value -     #     # Contract ABI
    # public_key: String -     #     # Public key encoded in `hex`.
    # message: String -     #     # Unsigned message BOC encoded in `base64`.
    # signature: String -     #     # Signature encoded in `hex`.
    # RESPONSE: ResultOfAttachSignature
    # message: String -     #     # Signed message BOC
    # message_id: String -     #     # Message ID
    def attach_signature(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfDecodeMessage
    # abi: Value -     #     # contract ABI
    # message: String -     #     # Message BOC
    # RESPONSE: DecodedMessageBody
    # body_type: MessageBodyType -     #     # Type of the message body content.
    # name: String -     #     # Function or event name.
    # value: Value<Optional> -     #     # Parameters or result value.
    # header: FunctionHeader<Optional> -     #     # Function header.
    def decode_message(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfDecodeMessageBody
    # abi: Value -     #     # Contract ABI used to decode.
    # body: String -     #     # Message body BOC encoded in `base64`.
    # is_internal: Boolean -     #     # True if the body belongs to the internal message.
    # RESPONSE: DecodedMessageBody
    # body_type: MessageBodyType -     #     # Type of the message body content.
    # name: String -     #     # Function or event name.
    # value: Value<Optional> -     #     # Parameters or result value.
    # header: FunctionHeader<Optional> -     #     # Function header.
    def decode_message_body(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfEncodeAccount
    # state_init: StateInitSource -     #     # Source of the account state init.
    # balance: BigInt<Optional> -     #     # Initial balance.
    # last_trans_lt: BigInt<Optional> -     #     # Initial value for the `last_trans_lt`.
    # last_paid: Number<Optional> -     #     # Initial value for the `last_paid`.
    # boc_cache: BocCacheType<Optional> -     #     # Cache type to put the result.    #     # The BOC itself returned if no cache type provided
    # RESPONSE: ResultOfEncodeAccount
    # account: String -     #     # Account BOC encoded in `base64`.
    # id: String -     #     # Account ID  encoded in `hex`.
    def encode_account(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

  end
end

