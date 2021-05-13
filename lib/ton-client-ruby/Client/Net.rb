module TonClient

  class Net
    include CommonInstanceHelpers

    attr_reader :core, :context
    MODULE = self.to_s.downcase.gsub(/^(.+::|)(\w+)$/, '\2').freeze

    def initialize(context: Context.new, core: TonClient::TonBinding)
      @context = context
      @core = core
    end

    # INPUT: ParamsOfQuery
    # query: String -     # GraphQL query text.
    # variables: Value -     # Variables used in query.    # Must be a map with named values that can be used in query.
    # RESPONSE: ResultOfQuery
    # result: Value -     # Result provided by DAppServer.
    def query(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfBatchQuery
    # operations: Array -     # List of query operations that must be performed per single fetch.
    # RESPONSE: ResultOfBatchQuery
    # results: Array -     # Result values for batched queries.    # Returns an array of values. Each value corresponds to `queries` item.
    def batch_query(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfQueryCollection
    # collection: String -     # Collection name (accounts, blocks, transactions, messages, block_signatures)
    # filter: Value -     # Collection filter
    # result: String -     # Projection (result) string
    # order: Array<Optional> -     # Sorting order
    # limit: Number<Optional> -     # Number of documents to return
    # RESPONSE: ResultOfQueryCollection
    # result: Array -     # Objects that match the provided criteria
    def query_collection(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfAggregateCollection
    # collection: String -     # Collection name (accounts, blocks, transactions, messages, block_signatures)
    # filter: Value -     # Collection filter
    # fields: Array<Optional> -     # Projection (result) string
    # RESPONSE: ResultOfAggregateCollection
    # values: Value -     # Values for requested fields.    # Returns an array of strings. Each string refers to the corresponding `fields` item.Numeric value is returned as a decimal string representations.
    def aggregate_collection(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfWaitForCollection
    # collection: String -     # Collection name (accounts, blocks, transactions, messages, block_signatures)
    # filter: Value -     # Collection filter
    # result: String -     # Projection (result) string
    # timeout: Number<Optional> -     # Query timeout
    # RESPONSE: ResultOfWaitForCollection
    # result: Value -     # First found object that matches the provided criteria
    def wait_for_collection(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ResultOfSubscribeCollection
    # handle: Number -     # Subscription handle.    # Must be closed with `unsubscribe`
    def unsubscribe(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfSubscribeCollection
    # collection: String -     # Collection name (accounts, blocks, transactions, messages, block_signatures)
    # filter: Value -     # Collection filter
    # result: String -     # Projection (result) string
    # RESPONSE: ResultOfSubscribeCollection
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

    # INPUT: ParamsOfFindLastShardBlock
    # address: String -     # Account address
    # RESPONSE: ResultOfFindLastShardBlock
    # block_id: String -     # Account shard last block ID
    def find_last_shard_block(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # RESPONSE: EndpointsSet
    # endpoints: Array -     # List of endpoints provided by server
    def fetch_endpoints(&block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: {}, &block)
    end

    # INPUT: EndpointsSet
    # endpoints: Array -     # List of endpoints provided by server
    def set_endpoints(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfQueryCounterparties
    # account: String -     # Account address
    # result: String -     # Projection (result) string
    # first: Number<Optional> -     # Number of counterparties to return
    # after: String<Optional> -     # `cursor` field of the last received result
    # RESPONSE: ResultOfQueryCollection
    # result: Array -     # Objects that match the provided criteria
    def query_counterparties(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

  end
end

