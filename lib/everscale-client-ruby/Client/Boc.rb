module TonClient

  class Boc
    include CommonInstanceHelpers

    attr_reader :core, :context
    MODULE = self.to_s.downcase.gsub(/^(.+::|)(\w+)$/, '\2').freeze

    def initialize(context: Context.new, core: TonClient::TonBinding)
      @context = context
      @core = core
    end

    # INPUT: ParamsOfParse
    # boc: String -     #     # BOC encoded as base64
    # RESPONSE: ResultOfParse
    # parsed: Value -     #     # JSON containing parsed BOC
    def parse_message(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfParse
    # boc: String -     #     # BOC encoded as base64
    # RESPONSE: ResultOfParse
    # parsed: Value -     #     # JSON containing parsed BOC
    def parse_transaction(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfParse
    # boc: String -     #     # BOC encoded as base64
    # RESPONSE: ResultOfParse
    # parsed: Value -     #     # JSON containing parsed BOC
    def parse_account(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfParse
    # boc: String -     #     # BOC encoded as base64
    # RESPONSE: ResultOfParse
    # parsed: Value -     #     # JSON containing parsed BOC
    def parse_block(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfParseShardstate
    # boc: String -     #     # BOC encoded as base64
    # id: String -     #     # Shardstate identificator
    # workchain_id: Number -     #     # Workchain shardstate belongs to
    # RESPONSE: ResultOfParse
    # parsed: Value -     #     # JSON containing parsed BOC
    def parse_shardstate(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfGetBlockchainConfig
    # block_boc: String -     #     # Key block BOC or zerostate BOC encoded as base64
    # RESPONSE: ResultOfGetBlockchainConfig
    # config_boc: String -     #     # Blockchain config BOC encoded as base64
    def get_blockchain_config(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfGetBocHash
    # boc: String -     #     # BOC encoded as base64 or BOC handle
    # RESPONSE: ResultOfGetBocHash
    # hash: String -     #     # BOC root hash encoded with hex
    def get_boc_hash(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfGetBocDepth
    # boc: String -     #     # BOC encoded as base64 or BOC handle
    # RESPONSE: ResultOfGetBocDepth
    # depth: Number -     #     # BOC root cell depth
    def get_boc_depth(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfGetCodeFromTvc
    # tvc: String -     #     # Contract TVC image or image BOC handle
    # RESPONSE: ResultOfGetCodeFromTvc
    # code: String -     #     # Contract code encoded as base64
    def get_code_from_tvc(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfBocCacheGet
    # boc_ref: String -     #     # Reference to the cached BOC
    # RESPONSE: ResultOfBocCacheGet
    # boc: String<Optional> -     #     # BOC encoded as base64.
    def cache_get(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfBocCacheSet
    # boc: String -     #     # BOC encoded as base64 or BOC reference
    # cache_type: BocCacheType -     #     # Cache type
    # RESPONSE: ResultOfBocCacheSet
    # boc_ref: String -     #     # Reference to the cached BOC
    def cache_set(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfBocCacheUnpin
    # pin: String -     #     # Pinned name
    # boc_ref: String<Optional> -     #     # Reference to the cached BOC.    #     # If it is provided then only referenced BOC is unpinned
    def cache_unpin(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfEncodeBoc
    # builder: Array -     #     # Cell builder operations.
    # boc_cache: BocCacheType<Optional> -     #     # Cache type to put the result. The BOC itself returned if no cache type provided.
    # RESPONSE: ResultOfEncodeBoc
    # boc: String -     #     # Encoded cell BOC or BOC cache key.
    def encode_boc(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfGetCodeSalt
    # code: String -     #     # Contract code BOC encoded as base64 or code BOC handle
    # boc_cache: BocCacheType<Optional> -     #     # Cache type to put the result. The BOC itself returned if no cache type provided.
    # RESPONSE: ResultOfGetCodeSalt
    # salt: String<Optional> -     #     # Contract code salt if present.    #     # BOC encoded as base64 or BOC handle
    def get_code_salt(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfSetCodeSalt
    # code: String -     #     # Contract code BOC encoded as base64 or code BOC handle
    # salt: String -     #     # Code salt to set.    #     # BOC encoded as base64 or BOC handle
    # boc_cache: BocCacheType<Optional> -     #     # Cache type to put the result. The BOC itself returned if no cache type provided.
    # RESPONSE: ResultOfSetCodeSalt
    # code: String -     #     # Contract code with salt set.    #     # BOC encoded as base64 or BOC handle
    def set_code_salt(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfDecodeTvc
    # tvc: String -     #     # Contract TVC image BOC encoded as base64 or BOC handle
    # boc_cache: BocCacheType<Optional> -     #     # Cache type to put the result. The BOC itself returned if no cache type provided.
    # RESPONSE: ResultOfDecodeTvc
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
    def decode_tvc(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfEncodeTvc
    # code: String<Optional> -     #     # Contract code BOC encoded as base64 or BOC handle
    # data: String<Optional> -     #     # Contract data BOC encoded as base64 or BOC handle
    # library: String<Optional> -     #     # Contract library BOC encoded as base64 or BOC handle
    # tick: Boolean<Optional> -     #     # `special.tick` field.    #     # Specifies the contract ability to handle tick transactions
    # tock: Boolean<Optional> -     #     # `special.tock` field.    #     # Specifies the contract ability to handle tock transactions
    # split_depth: Number<Optional> -     #     # Is present and non-zero only in instances of large smart contracts
    # boc_cache: BocCacheType<Optional> -     #     # Cache type to put the result. The BOC itself returned if no cache type provided.
    # RESPONSE: ResultOfEncodeTvc
    # tvc: String -     #     # Contract TVC image BOC encoded as base64 or BOC handle of boc_cache parameter was specified
    def encode_tvc(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
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
    def encode_external_in_message(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfGetCompilerVersion
    # code: String -     #     # Contract code BOC encoded as base64 or code BOC handle
    # RESPONSE: ResultOfGetCompilerVersion
    # version: String<Optional> -     #     # Compiler version, for example 'sol 0.49.0'
    def get_compiler_version(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

  end
end

