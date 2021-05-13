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
    # boc: String -     #     # BOC encoded as base64
    # RESPONSE: ResultOfGetBocHash
    # hash: String -     #     # BOC root hash encoded with hex
    def get_boc_hash(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfGetCodeFromTvc
    # tvc: String -     #     # Contract TVC image encoded as base64
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

  end
end

