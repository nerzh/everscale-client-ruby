module TonClient

  class Abi
    include CommonInstanceHelpers

    attr_reader :context, :request_id, :requests, :monitor
    MODULE = self.to_s.downcase.gsub(/^(.+::|)(\w+)$/, '\2').freeze

    def initialize(context: nil, request_id: nil, requests: nil, monitor: nil)
      @context = context
      @request_id = request_id
      @requests = requests
      @monitor = monitor
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
    # address: String<Optional> -     #     # Destination address of the message    #     # Since ABI version 2.3 destination address of external inbound message is used in messagebody signature calculation. Should be provided when signed external inbound message body iscreated. Otherwise can be omitted.
    # RESPONSE: ResultOfEncodeMessageBody
    # body: String -     #     # Message body BOC encoded with `base64`.
    # data_to_sign: String<Optional> -     #     # Optional data to sign.    #     # Encoded with `base64`.
    # # Presents when `message` is unsigned. Can be used for externalmessage signing. Is this case you need to sing this data andproduce signed message using `abi.attach_signature`.
    # Async
    def encode_message_body(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def encode_message_body_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

    # INPUT: ParamsOfAttachSignatureToMessageBody
    # abi: Value -     #     # Contract ABI
    # public_key: String -     #     # Public key.    #     # Must be encoded with `hex`.
    # message: String -     #     # Unsigned message body BOC.    #     # Must be encoded with `base64`.
    # signature: String -     #     # Signature.    #     # Must be encoded with `hex`.
    # RESPONSE: ResultOfAttachSignatureToMessageBody
    # body: String - 
    # Async
    def attach_signature_to_message_body(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def attach_signature_to_message_body_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
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
    # Async
    def encode_message(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def encode_message_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
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
    # Async
    def encode_internal_message(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def encode_internal_message_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

    # INPUT: ParamsOfAttachSignature
    # abi: Value -     #     # Contract ABI
    # public_key: String -     #     # Public key encoded in `hex`.
    # message: String -     #     # Unsigned message BOC encoded in `base64`.
    # signature: String -     #     # Signature encoded in `hex`.
    # RESPONSE: ResultOfAttachSignature
    # message: String -     #     # Signed message BOC
    # message_id: String -     #     # Message ID
    # Async
    def attach_signature(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def attach_signature_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

    # INPUT: ParamsOfDecodeMessage
    # abi: Value -     #     # contract ABI
    # message: String -     #     # Message BOC
    # allow_partial: Boolean<Optional> -     #     # Flag allowing partial BOC decoding when ABI doesn't describe the full body BOC. Controls decoder behaviour when after decoding all described in ABI params there are some data left in BOC: `true` - return decoded values `false` - return error of incomplete BOC deserialization (default)
    # function_name: String<Optional> -     #     # Function name or function id if is known in advance
    # data_layout: DataLayout<Optional> - 
    # RESPONSE: DecodedMessageBody
    # body_type: MessageBodyType -     #     # Type of the message body content.
    # name: String -     #     # Function or event name.
    # value: Value<Optional> -     #     # Parameters or result value.
    # header: FunctionHeader<Optional> -     #     # Function header.
    # Async
    def decode_message(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def decode_message_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

    # INPUT: ParamsOfDecodeMessageBody
    # abi: Value -     #     # Contract ABI used to decode.
    # body: String -     #     # Message body BOC encoded in `base64`.
    # is_internal: Boolean -     #     # True if the body belongs to the internal message.
    # allow_partial: Boolean<Optional> -     #     # Flag allowing partial BOC decoding when ABI doesn't describe the full body BOC. Controls decoder behaviour when after decoding all described in ABI params there are some data left in BOC: `true` - return decoded values `false` - return error of incomplete BOC deserialization (default)
    # function_name: String<Optional> -     #     # Function name or function id if is known in advance
    # data_layout: DataLayout<Optional> - 
    # RESPONSE: DecodedMessageBody
    # body_type: MessageBodyType -     #     # Type of the message body content.
    # name: String -     #     # Function or event name.
    # value: Value<Optional> -     #     # Parameters or result value.
    # header: FunctionHeader<Optional> -     #     # Function header.
    # Async
    def decode_message_body(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def decode_message_body_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
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
    # Async
    def encode_account(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def encode_account_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

    # INPUT: ParamsOfDecodeAccountData
    # abi: Value -     #     # Contract ABI
    # data: String -     #     # Data BOC or BOC handle
    # allow_partial: Boolean<Optional> -     #     # Flag allowing partial BOC decoding when ABI doesn't describe the full body BOC. Controls decoder behaviour when after decoding all described in ABI params there are some data left in BOC: `true` - return decoded values `false` - return error of incomplete BOC deserialization (default)
    # RESPONSE: ResultOfDecodeAccountData
    # data: Value -     #     # Decoded data as a JSON structure.
    # Async
    def decode_account_data(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def decode_account_data_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

    # INPUT: ParamsOfUpdateInitialData
    # abi: Value<Optional> -     #     # Contract ABI
    # data: String -     #     # Data BOC or BOC handle
    # initial_data: Value -     #     # List of initial values for contract's static variables.    #     # `abi` parameter should be provided to set initial data
    # initial_pubkey: String<Optional> -     #     # Initial account owner's public key to set into account data
    # boc_cache: BocCacheType<Optional> -     #     # Cache type to put the result. The BOC itself returned if no cache type provided.
    # RESPONSE: ResultOfUpdateInitialData
    # data: String -     #     # Updated data BOC or BOC handle
    # Async
    def update_initial_data(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def update_initial_data_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

    # INPUT: ParamsOfEncodeInitialData
    # abi: Value<Optional> -     #     # Contract ABI
    # initial_data: Value -     #     # List of initial values for contract's static variables.    #     # `abi` parameter should be provided to set initial data
    # initial_pubkey: String<Optional> -     #     # Initial account owner's public key to set into account data
    # boc_cache: BocCacheType<Optional> -     #     # Cache type to put the result. The BOC itself returned if no cache type provided.
    # RESPONSE: ResultOfEncodeInitialData
    # data: String -     #     # Updated data BOC or BOC handle
    # Async
    def encode_initial_data(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def encode_initial_data_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

    # INPUT: ParamsOfDecodeInitialData
    # abi: Value<Optional> -     #     # Contract ABI.    #     # Initial data is decoded if this parameter is provided
    # data: String -     #     # Data BOC or BOC handle
    # allow_partial: Boolean<Optional> -     #     # Flag allowing partial BOC decoding when ABI doesn't describe the full body BOC. Controls decoder behaviour when after decoding all described in ABI params there are some data left in BOC: `true` - return decoded values `false` - return error of incomplete BOC deserialization (default)
    # RESPONSE: ResultOfDecodeInitialData
    # initial_data: Value<Optional> -     #     # List of initial values of contract's public variables.    #     # Initial data is decoded if `abi` input parameter is provided
    # initial_pubkey: String -     #     # Initial account owner's public key
    # Async
    def decode_initial_data(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def decode_initial_data_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

    # INPUT: ParamsOfDecodeBoc
    # params: Array -     #     # Parameters to decode from BOC
    # boc: String -     #     # Data BOC or BOC handle
    # allow_partial: Boolean - 
    # RESPONSE: ResultOfDecodeBoc
    # data: Value -     #     # Decoded data as a JSON structure.
    # Async
    def decode_boc(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def decode_boc_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

    # INPUT: ParamsOfAbiEncodeBoc
    # params: Array -     #     # Parameters to encode into BOC
    # data: Value -     #     # Parameters and values as a JSON structure
    # boc_cache: BocCacheType<Optional> -     #     # Cache type to put the result.    #     # The BOC itself returned if no cache type provided
    # RESPONSE: ResultOfAbiEncodeBoc
    # boc: String -     #     # BOC encoded as base64
    # Async
    def encode_boc(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def encode_boc_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

    # INPUT: ParamsOfCalcFunctionId
    # abi: Value -     #     # Contract ABI.
    # function_name: String -     #     # Contract function name
    # output: Boolean<Optional> -     #     # If set to `true` output function ID will be returned which is used in contract response. Default is `false`
    # RESPONSE: ResultOfCalcFunctionId
    # function_id: Number -     #     # Contract function ID
    # Async
    def calc_function_id(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def calc_function_id_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

    # INPUT: ParamsOfGetSignatureData
    # abi: Value -     #     # Contract ABI used to decode.
    # message: String -     #     # Message BOC encoded in `base64`.
    # RESPONSE: ResultOfGetSignatureData
    # signature: String -     #     # Signature from the message in `hex`.
    # hash: String -     #     # Hash to verify the signature in `base64`.
    # Async
    def get_signature_data(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def get_signature_data_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

  end
end

