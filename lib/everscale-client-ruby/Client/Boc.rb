module TonClient

  class Boc
    include CommonInstanceHelpers

    attr_reader :context, :request_id, :requests, :monitor
    MODULE = self.to_s.downcase.gsub(/^(.+::|)(\w+)$/, '\2').freeze

    def initialize(context: nil, request_id: nil, requests: nil, monitor: nil)
      @context = context
      @request_id = request_id
      @requests = requests
      @monitor = monitor
    end

    # INPUT: ParamsOfDecodeTvc
    # tvc: String -     #     # Contract TVC BOC encoded as base64 or BOC handle
    # RESPONSE: ResultOfDecodeTvc
    # tvc: Tvc -     #     # Decoded TVC
    # Async
    def decode_tvc(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def decode_tvc_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

    # INPUT: ParamsOfParse
    # boc: String -     #     # BOC encoded as base64
    # RESPONSE: ResultOfParse
    # parsed: Value -     #     # JSON containing parsed BOC
    # Async
    def parse_message(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def parse_message_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

    # INPUT: ParamsOfParse
    # boc: String -     #     # BOC encoded as base64
    # RESPONSE: ResultOfParse
    # parsed: Value -     #     # JSON containing parsed BOC
    # Async
    def parse_transaction(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def parse_transaction_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

    # INPUT: ParamsOfParse
    # boc: String -     #     # BOC encoded as base64
    # RESPONSE: ResultOfParse
    # parsed: Value -     #     # JSON containing parsed BOC
    # Async
    def parse_account(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def parse_account_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

    # INPUT: ParamsOfParse
    # boc: String -     #     # BOC encoded as base64
    # RESPONSE: ResultOfParse
    # parsed: Value -     #     # JSON containing parsed BOC
    # Async
    def parse_block(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def parse_block_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

    # INPUT: ParamsOfParseShardstate
    # boc: String -     #     # BOC encoded as base64
    # id: String -     #     # Shardstate identifier
    # workchain_id: Number -     #     # Workchain shardstate belongs to
    # RESPONSE: ResultOfParse
    # parsed: Value -     #     # JSON containing parsed BOC
    # Async
    def parse_shardstate(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def parse_shardstate_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

    # INPUT: ParamsOfGetBlockchainConfig
    # block_boc: String -     #     # Key block BOC or zerostate BOC encoded as base64
    # RESPONSE: ResultOfGetBlockchainConfig
    # config_boc: String -     #     # Blockchain config BOC encoded as base64
    # Async
    def get_blockchain_config(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def get_blockchain_config_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

    # INPUT: ParamsOfGetBocHash
    # boc: String -     #     # BOC encoded as base64 or BOC handle
    # RESPONSE: ResultOfGetBocHash
    # hash: String -     #     # BOC root hash encoded with hex
    # Async
    def get_boc_hash(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def get_boc_hash_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

    # INPUT: ParamsOfGetBocDepth
    # boc: String -     #     # BOC encoded as base64 or BOC handle
    # RESPONSE: ResultOfGetBocDepth
    # depth: Number -     #     # BOC root cell depth
    # Async
    def get_boc_depth(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def get_boc_depth_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

    # INPUT: ParamsOfGetCodeFromTvc
    # tvc: String -     #     # Contract TVC image or image BOC handle
    # RESPONSE: ResultOfGetCodeFromTvc
    # code: String -     #     # Contract code encoded as base64
    # Async
    def get_code_from_tvc(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def get_code_from_tvc_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

    # INPUT: ParamsOfBocCacheGet
    # boc_ref: String -     #     # Reference to the cached BOC
    # RESPONSE: ResultOfBocCacheGet
    # boc: String<Optional> -     #     # BOC encoded as base64.
    # Async
    def cache_get(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def cache_get_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

    # INPUT: ParamsOfBocCacheSet
    # boc: String -     #     # BOC encoded as base64 or BOC reference
    # cache_type: BocCacheType -     #     # Cache type
    # RESPONSE: ResultOfBocCacheSet
    # boc_ref: String -     #     # Reference to the cached BOC
    # Async
    def cache_set(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def cache_set_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

    # INPUT: ParamsOfBocCacheUnpin
    # pin: String -     #     # Pinned name
    # boc_ref: String<Optional> -     #     # Reference to the cached BOC.    #     # If it is provided then only referenced BOC is unpinned
    # Async
    def cache_unpin(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def cache_unpin_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

    # INPUT: ParamsOfEncodeBoc
    # builder: Array -     #     # Cell builder operations.
    # boc_cache: BocCacheType<Optional> -     #     # Cache type to put the result. The BOC itself returned if no cache type provided.
    # RESPONSE: ResultOfEncodeBoc
    # boc: String -     #     # Encoded cell BOC or BOC cache key.
    # Async
    def encode_boc(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def encode_boc_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

    # INPUT: ParamsOfGetCodeSalt
    # code: String -     #     # Contract code BOC encoded as base64 or code BOC handle
    # boc_cache: BocCacheType<Optional> -     #     # Cache type to put the result. The BOC itself returned if no cache type provided.
    # RESPONSE: ResultOfGetCodeSalt
    # salt: String<Optional> -     #     # Contract code salt if present.    #     # BOC encoded as base64 or BOC handle
    # Async
    def get_code_salt(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def get_code_salt_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

    # INPUT: ParamsOfSetCodeSalt
    # code: String -     #     # Contract code BOC encoded as base64 or code BOC handle
    # salt: String -     #     # Code salt to set.    #     # BOC encoded as base64 or BOC handle
    # boc_cache: BocCacheType<Optional> -     #     # Cache type to put the result. The BOC itself returned if no cache type provided.
    # RESPONSE: ResultOfSetCodeSalt
    # code: String -     #     # Contract code with salt set.    #     # BOC encoded as base64 or BOC handle
    # Async
    def set_code_salt(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def set_code_salt_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

    # INPUT: ParamsOfDecodeStateInit
    # state_init: String -     #     # Contract StateInit image BOC encoded as base64 or BOC handle
    # boc_cache: BocCacheType<Optional> -     #     # Cache type to put the result. The BOC itself returned if no cache type provided.
    # RESPONSE: ResultOfDecodeStateInit
    # code: String<Optional> -     #     # Contract code BOC encoded as base64 or BOC handle
    # code_hash: String<Optional> -     #     # Contract code hash
    # code_depth: Number<Optional> -     #     # Contract code depth
    # data: String<Optional> -     #     # Contract data BOC encoded as base64 or BOC handle
    # data_hash: String<Optional> -     #     # Contract data hash
    # data_depth: Number<Optional> -     #     # Contract data depth
    # library: String<Optional> -     #     # Contract library BOC encoded as base64 or BOC handle
    # tick: Boolean<Optional> -     #     # `special.tick` field.    #     # Specifies the contract ability to handle tick transactions
    # tock: Boolean<Optional> -     #     # `special.tock` field.    #     # Specifies the contract ability to handle tock transactions
    # split_depth: Number<Optional> -     #     # Is present and non-zero only in instances of large smart contracts
    # compiler_version: String<Optional> -     #     # Compiler version, for example 'sol 0.49.0'
    # Async
    def decode_state_init(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def decode_state_init_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

    # INPUT: ParamsOfEncodeStateInit
    # code: String<Optional> -     #     # Contract code BOC encoded as base64 or BOC handle
    # data: String<Optional> -     #     # Contract data BOC encoded as base64 or BOC handle
    # library: String<Optional> -     #     # Contract library BOC encoded as base64 or BOC handle
    # tick: Boolean<Optional> -     #     # `special.tick` field.    #     # Specifies the contract ability to handle tick transactions
    # tock: Boolean<Optional> -     #     # `special.tock` field.    #     # Specifies the contract ability to handle tock transactions
    # split_depth: Number<Optional> -     #     # Is present and non-zero only in instances of large smart contracts
    # boc_cache: BocCacheType<Optional> -     #     # Cache type to put the result. The BOC itself returned if no cache type provided.
    # RESPONSE: ResultOfEncodeStateInit
    # state_init: String -     #     # Contract StateInit image BOC encoded as base64 or BOC handle of boc_cache parameter was specified
    # Async
    def encode_state_init(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def encode_state_init_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

    # INPUT: ParamsOfEncodeExternalInMessage
    # src: String<Optional> -     #     # Source address.
    # dst: String -     #     # Destination address.
    # init: String<Optional> -     #     # Bag of cells with state init (used in deploy messages).
    # body: String<Optional> -     #     # Bag of cells with the message body encoded as base64.
    # boc_cache: BocCacheType<Optional> -     #     # Cache type to put the result.    #     # The BOC itself returned if no cache type provided
    # RESPONSE: ResultOfEncodeExternalInMessage
    # message: String -     #     # Message BOC encoded with `base64`.
    # message_id: String -     #     # Message id.
    # Async
    def encode_external_in_message(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def encode_external_in_message_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

    # INPUT: ParamsOfGetCompilerVersion
    # code: String -     #     # Contract code BOC encoded as base64 or code BOC handle
    # RESPONSE: ResultOfGetCompilerVersion
    # version: String<Optional> -     #     # Compiler version, for example 'sol 0.49.0'
    # Async
    def get_compiler_version(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def get_compiler_version_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

  end
end

