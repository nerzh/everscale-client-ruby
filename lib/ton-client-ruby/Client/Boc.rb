module TonClient

  class Boc
    include CommonInstanceHelpers

    attr_reader :core, :context
    MODULE = self.to_s.downcase.gsub(/^(.+::|)(\w+)$/, '\2').freeze

    def initialize(context: Context.new, core: TonClient::TonBinding)
      @context = context
      @core = core
    end

    # INPUT: TSDKParamsOfParse
    # boc: String -     # BOC encoded as base64
    # RESPONSE: TSDKResultOfParse
    # parsed: Value -     # JSON containing parsed BOC
    def parse_message(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: TSDKParamsOfParse
    # boc: String -     # BOC encoded as base64
    # RESPONSE: TSDKResultOfParse
    # parsed: Value -     # JSON containing parsed BOC
    def parse_transaction(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: TSDKParamsOfParse
    # boc: String -     # BOC encoded as base64
    # RESPONSE: TSDKResultOfParse
    # parsed: Value -     # JSON containing parsed BOC
    def parse_account(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: TSDKParamsOfParse
    # boc: String -     # BOC encoded as base64
    # RESPONSE: TSDKResultOfParse
    # parsed: Value -     # JSON containing parsed BOC
    def parse_block(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: TSDKParamsOfParseShardstate
    # boc: String -     # BOC encoded as base64
    # id: String -     # Shardstate identificator
    # workchain_id: Number -     # Workchain shardstate belongs to
    # RESPONSE: TSDKResultOfParse
    # parsed: Value -     # JSON containing parsed BOC
    def parse_shardstate(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: TSDKParamsOfGetBlockchainConfig
    # block_boc: String -     # Key block BOC or zerostate BOC encoded as base64
    # RESPONSE: TSDKResultOfGetBlockchainConfig
    # config_boc: String -     # Blockchain config BOC encoded as base64
    def get_blockchain_config(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: TSDKParamsOfGetBocHash
    # boc: String -     # BOC encoded as base64
    # RESPONSE: TSDKResultOfGetBocHash
    # hash: String -     # BOC root hash encoded with hex
    def get_boc_hash(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: TSDKParamsOfGetCodeFromTvc
    # tvc: String -     # Contract TVC image encoded as base64
    # RESPONSE: TSDKResultOfGetCodeFromTvc
    # code: String -     # Contract code encoded as base64
    def get_code_from_tvc(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: TSDKParamsOfBocCacheGet
    # boc_ref: String -     # Reference to the cached BOC
    # RESPONSE: TSDKResultOfBocCacheGet
    # boc: String -     # BOC encoded as base64.
    def cache_get(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: TSDKParamsOfBocCacheSet
    # boc: String -     # BOC encoded as base64 or BOC reference
    # cache_type: TSDKBocCacheType -     # Cache type
    # RESPONSE: TSDKResultOfBocCacheSet
    # boc_ref: String -     # Reference to the cached BOC
    def cache_set(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: TSDKParamsOfBocCacheUnpin
    # pin: String -     # Pinned name
    # boc_ref: String -     # Reference to the cached BOC.    # If it is provided then only referenced BOC is unpinned
    def cache_unpin(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: TSDKParamsOfEncodeBoc
    # builder: Array -     # Cell builder operations.
    # boc_cache: TSDKBocCacheType -     # Cache type to put the result. The BOC itself returned if no cache type provided.
    # RESPONSE: TSDKResultOfEncodeBoc
    # boc: String -     # Encoded cell BOC or BOC cache key.
    def encode_boc(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

  end
end

