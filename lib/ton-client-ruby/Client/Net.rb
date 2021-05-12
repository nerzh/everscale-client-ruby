module TonClient

  class Net
    include CommonInstanceHelpers

    attr_reader :core, :context
    MODULE = self.to_s.downcase.gsub(/^(.+::|)(\w+)$/, '\2').freeze

    def initialize(context: Context.new, core: TonClient::TonBinding)
      @context = context
      @core = core
    end

    # INPUT: TSDKParamsOfQuery
    # query: String -     # GraphQL query text.
    # variables: Value -     # Variables used in query.    # Must be a map with named values that can be used in query.
    # RESPONSE: TSDKResultOfQuery
    # result: Value -     # Result provided by DAppServer.
    def query(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: TSDKParamsOfBatchQuery
    # operations: Array -     # List of query operations that must be performed per single fetch.
    # RESPONSE: TSDKResultOfBatchQuery
    # results: Array -     # Result values for batched queries.    # Returns an array of values. Each value corresponds to `queries` item.
    def batch_query(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: TSDKParamsOfQueryCollection
    # collection: String -     # Collection name (accounts, blocks, transactions, messages, block_signatures)
    # filter: Value -     # Collection filter
    # result: String -     # Projection (result) string
    # order: Array -     # Sorting order
    # limit: Number -     # Number of documents to return
    # RESPONSE: TSDKResultOfQueryCollection
    # result: Array -     # Objects that match the provided criteria
    def query_collection(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: TSDKParamsOfAggregateCollection
    # collection: String -     # Collection name (accounts, blocks, transactions, messages, block_signatures)
    # filter: Value -     # Collection filter
    # fields: Array -     # Projection (result) string
    # RESPONSE: TSDKResultOfAggregateCollection
    # values: Value -     # Values for requested fields.    # Returns an array of strings. Each string refers to the corresponding `fields` item.Numeric value is returned as a decimal string representations.
    def aggregate_collection(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: TSDKParamsOfWaitForCollection
    # collection: String -     # Collection name (accounts, blocks, transactions, messages, block_signatures)
    # filter: Value -     # Collection filter
    # result: String -     # Projection (result) string
    # timeout: Number -     # Query timeout
    # RESPONSE: TSDKResultOfWaitForCollection
    # result: Value -     # First found object that matches the provided criteria
    def wait_for_collection(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: TSDKResultOfSubscribeCollection
    # handle: Number -     # Subscription handle.    # Must be closed with `unsubscribe`
    def unsubscribe(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: TSDKParamsOfSubscribeCollection
    # collection: String -     # Collection name (accounts, blocks, transactions, messages, block_signatures)
    # filter: Value -     # Collection filter
    # result: String -     # Projection (result) string
    # RESPONSE: TSDKResultOfSubscribeCollection
    # handle: Number -     # Subscription handle.    # Must be closed with `unsubscribe`
    def subscribe_collection(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    def suspend(&block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: {}, &block)
    end

    def resume(&block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: {}, &block)
    end

    # INPUT: TSDKParamsOfFindLastShardBlock
    # address: String -     # Account address
    # RESPONSE: TSDKResultOfFindLastShardBlock
    # block_id: String -     # Account shard last block ID
    def find_last_shard_block(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # RESPONSE: TSDKEndpointsSet
    # endpoints: Array -     # List of endpoints provided by server
    def fetch_endpoints(&block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: {}, &block)
    end

    # INPUT: TSDKEndpointsSet
    # endpoints: Array -     # List of endpoints provided by server
    def set_endpoints(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: TSDKParamsOfQueryCounterparties
    # account: String -     # Account address
    # result: String -     # Projection (result) string
    # first: Number -     # Number of counterparties to return
    # after: String -     # `cursor` field of the last received result
    # RESPONSE: TSDKResultOfQueryCollection
    # result: Array -     # Objects that match the provided criteria
    def query_counterparties(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

  end
end

