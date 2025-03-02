module TonClient

  class Net
    include CommonInstanceHelpers

    attr_reader :context, :request_id, :requests, :monitor
    MODULE = self.to_s.downcase.gsub(/^(.+::|)(\w+)$/, '\2').freeze

    def initialize(context: nil, request_id: nil, requests: nil, monitor: nil)
      @context = context
      @request_id = request_id
      @requests = requests
      @monitor = monitor
    end

    # INPUT: ParamsOfQuery
    # query: String -     #     # GraphQL query text.
    # variables: Value -     #     # Variables used in query.    #     # Must be a map with named values that can be used in query.
    # RESPONSE: ResultOfQuery
    # result: Value -     #     # Result provided by DAppServer.
    # Async
    def query(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def query_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

    # INPUT: ParamsOfBatchQuery
    # operations: Array -     #     # List of query operations that must be performed per single fetch.
    # RESPONSE: ResultOfBatchQuery
    # results: Array -     #     # Result values for batched queries.    #     # Returns an array of values. Each value corresponds to `queries` item.
    # Async
    def batch_query(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def batch_query_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

    # INPUT: ParamsOfQueryCollection
    # collection: String -     #     # Collection name (accounts, blocks, transactions, messages, block_signatures)
    # filter: Value -     #     # Collection filter
    # result: String -     #     # Projection (result) string
    # order: Array<Optional> -     #     # Sorting order
    # limit: Number<Optional> -     #     # Number of documents to return
    # RESPONSE: ResultOfQueryCollection
    # result: Array -     #     # Objects that match the provided criteria
    # Async
    def query_collection(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def query_collection_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

    # INPUT: ParamsOfAggregateCollection
    # collection: String -     #     # Collection name (accounts, blocks, transactions, messages, block_signatures)
    # filter: Value -     #     # Collection filter
    # fields: Array<Optional> -     #     # Projection (result) string
    # RESPONSE: ResultOfAggregateCollection
    # values: Value -     #     # Values for requested fields.    #     # Returns an array of strings. Each string refers to the corresponding `fields` item.
    # Numeric value is returned as a decimal string representations.
    # Async
    def aggregate_collection(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def aggregate_collection_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

    # INPUT: ParamsOfWaitForCollection
    # collection: String -     #     # Collection name (accounts, blocks, transactions, messages, block_signatures)
    # filter: Value -     #     # Collection filter
    # result: String -     #     # Projection (result) string
    # timeout: Number<Optional> -     #     # Query timeout
    # RESPONSE: ResultOfWaitForCollection
    # result: Value -     #     # First found object that matches the provided criteria
    # Async
    def wait_for_collection(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def wait_for_collection_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

    # INPUT: ResultOfSubscribeCollection
    # handle: Number -     #     # Subscription handle.    #     # Must be closed with `unsubscribe`
    # Async
    def unsubscribe(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def unsubscribe_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

    # INPUT: ParamsOfSubscribeCollection
    # collection: String -     #     # Collection name (accounts, blocks, transactions, messages, block_signatures)
    # filter: Value -     #     # Collection filter
    # result: String -     #     # Projection (result) string
    # RESPONSE: ResultOfSubscribeCollection
    # handle: Number -     #     # Subscription handle.    #     # Must be closed with `unsubscribe`
    # Async
    def subscribe_collection(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def subscribe_collection_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

    # INPUT: ParamsOfSubscribe
    # subscription: String -     #     # GraphQL subscription text.
    # variables: Value -     #     # Variables used in subscription.    #     # Must be a map with named values that can be used in query.
    # RESPONSE: ResultOfSubscribeCollection
    # handle: Number -     #     # Subscription handle.    #     # Must be closed with `unsubscribe`
    # Async
    def subscribe(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def subscribe_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

    # Async
    def suspend(&block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: {}, &block)
    end

    # Sync
    def suspend_sync()
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: {})
    end

    # Async
    def resume(&block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: {}, &block)
    end

    # Sync
    def resume_sync()
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: {})
    end

    # INPUT: ParamsOfFindLastShardBlock
    # address: String -     #     # Account address
    # RESPONSE: ResultOfFindLastShardBlock
    # block_id: String -     #     # Account shard last block ID
    # Async
    def find_last_shard_block(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def find_last_shard_block_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

    # RESPONSE: EndpointsSet
    # endpoints: Array -     #     # List of endpoints provided by server
    # Async
    def fetch_endpoints(&block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: {}, &block)
    end

    # Sync
    def fetch_endpoints_sync()
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: {})
    end

    # INPUT: EndpointsSet
    # endpoints: Array -     #     # List of endpoints provided by server
    # Async
    def set_endpoints(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def set_endpoints_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

    # RESPONSE: ResultOfGetEndpoints
    # query: String -     #     # Current query endpoint
    # endpoints: Array -     #     # List of all endpoints used by client
    # Async
    def get_endpoints(&block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: {}, &block)
    end

    # Sync
    def get_endpoints_sync()
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: {})
    end

    # INPUT: ParamsOfQueryCounterparties
    # account: String -     #     # Account address
    # result: String -     #     # Projection (result) string
    # first: Number<Optional> -     #     # Number of counterparties to return
    # after: String<Optional> -     #     # `cursor` field of the last received result
    # RESPONSE: ResultOfQueryCollection
    # result: Array -     #     # Objects that match the provided criteria
    # Async
    def query_counterparties(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def query_counterparties_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

    # INPUT: ParamsOfQueryTransactionTree
    # in_msg: String -     #     # Input message id.
    # abi_registry: Array<Optional> -     #     # List of contract ABIs that will be used to decode message bodies. Library will try to decode each returned message body using any ABI from the registry.
    # timeout: Number<Optional> -     #     # Timeout used to limit waiting time for the missing messages and transaction.    #     # If some of the following messages and transactions are missing yetThe maximum waiting time is regulated by this option.
    # Default value is 60000 (1 min). If `timeout` is set to 0 then function will wait infinitelyuntil the whole transaction tree is executed
    # transaction_max_count: Number<Optional> -     #     # Maximum transaction count to wait.    #     # If transaction tree contains more transaction then this parameter then only first `transaction_max_count` transaction are awaited and returned.
    # Default value is 50. If `transaction_max_count` is set to 0 then no limitation ontransaction count is used and all transaction are returned.
    # RESPONSE: ResultOfQueryTransactionTree
    # messages: Array -     #     # Messages.
    # transactions: Array -     #     # Transactions.
    # Async
    def query_transaction_tree(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def query_transaction_tree_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

    # INPUT: ParamsOfCreateBlockIterator
    # start_time: Number<Optional> -     #     # Starting time to iterate from.    #     # If the application specifies this parameter then the iterationincludes blocks with `gen_utime` >= `start_time`.
    # Otherwise the iteration starts from zero state.
    # Must be specified in seconds.
    # end_time: Number<Optional> -     #     # Optional end time to iterate for.    #     # If the application specifies this parameter then the iterationincludes blocks with `gen_utime` < `end_time`.
    # Otherwise the iteration never stops.
    # Must be specified in seconds.
    # shard_filter: Array<Optional> -     #     # Shard prefix filter.    #     # If the application specifies this parameter and it is not the empty arraythen the iteration will include items related to accounts that belongs tothe specified shard prefixes.
    # Shard prefix must be represented as a string "workchain:prefix".
    # Where `workchain` is a signed integer and the `prefix` if a hexadecimalrepresentation if the 64-bit unsigned integer with tagged shard prefix.
    # For example: "0:3800000000000000".
    # result: String<Optional> -     #     # Projection (result) string.    #     # List of the fields that must be returned for iterated items.
    # This field is the same as the `result` parameter ofthe `query_collection` function.
    # Note that iterated items can contains additional fields that arenot requested in the `result`.
    # RESPONSE: RegisteredIterator
    # handle: Number -     #     # Iterator handle.    #     # Must be removed using `remove_iterator`when it is no more needed for the application.
    # Async
    def create_block_iterator(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def create_block_iterator_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

    # INPUT: ParamsOfResumeBlockIterator
    # resume_state: Value -     #     # Iterator state from which to resume.    #     # Same as value returned from `iterator_next`.
    # RESPONSE: RegisteredIterator
    # handle: Number -     #     # Iterator handle.    #     # Must be removed using `remove_iterator`when it is no more needed for the application.
    # Async
    def resume_block_iterator(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def resume_block_iterator_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

    # INPUT: ParamsOfCreateTransactionIterator
    # start_time: Number<Optional> -     #     # Starting time to iterate from.    #     # If the application specifies this parameter then the iterationincludes blocks with `gen_utime` >= `start_time`.
    # Otherwise the iteration starts from zero state.
    # Must be specified in seconds.
    # end_time: Number<Optional> -     #     # Optional end time to iterate for.    #     # If the application specifies this parameter then the iterationincludes blocks with `gen_utime` < `end_time`.
    # Otherwise the iteration never stops.
    # Must be specified in seconds.
    # shard_filter: Array<Optional> -     #     # Shard prefix filters.    #     # If the application specifies this parameter and it is not an empty arraythen the iteration will include items related to accounts that belongs tothe specified shard prefixes.
    # Shard prefix must be represented as a string "workchain:prefix".
    # Where `workchain` is a signed integer and the `prefix` if a hexadecimalrepresentation if the 64-bit unsigned integer with tagged shard prefix.
    # For example: "0:3800000000000000".
    # Account address conforms to the shard filter ifit belongs to the filter workchain and the first bits of address match tothe shard prefix. Only transactions with suitable account addresses are iterated.
    # accounts_filter: Array<Optional> -     #     # Account address filter.    #     # Application can specify the list of accounts for whichit wants to iterate transactions.
    # If this parameter is missing or an empty list then the library iteratestransactions for all accounts that pass the shard filter.
    # Note that the library doesn't detect conflicts between the account filter and the shard filterif both are specified.
    # So it is an application responsibility to specify the correct filter combination.
    # result: String<Optional> -     #     # Projection (result) string.    #     # List of the fields that must be returned for iterated items.
    # This field is the same as the `result` parameter ofthe `query_collection` function.
    # Note that iterated items can contain additional fields that arenot requested in the `result`.
    # include_transfers: Boolean<Optional> -     #     # Include `transfers` field in iterated transactions.    #     # If this parameter is `true` then each transaction contains field`transfers` with list of transfer. See more about this structure in function description.
    # RESPONSE: RegisteredIterator
    # handle: Number -     #     # Iterator handle.    #     # Must be removed using `remove_iterator`when it is no more needed for the application.
    # Async
    def create_transaction_iterator(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def create_transaction_iterator_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

    # INPUT: ParamsOfResumeTransactionIterator
    # resume_state: Value -     #     # Iterator state from which to resume.    #     # Same as value returned from `iterator_next`.
    # accounts_filter: Array<Optional> -     #     # Account address filter.    #     # Application can specify the list of accounts for whichit wants to iterate transactions.
    # If this parameter is missing or an empty list then the library iteratestransactions for all accounts that passes the shard filter.
    # Note that the library doesn't detect conflicts between the account filter and the shard filterif both are specified.
    # So it is the application's responsibility to specify the correct filter combination.
    # RESPONSE: RegisteredIterator
    # handle: Number -     #     # Iterator handle.    #     # Must be removed using `remove_iterator`when it is no more needed for the application.
    # Async
    def resume_transaction_iterator(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def resume_transaction_iterator_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

    # INPUT: ParamsOfIteratorNext
    # iterator: Number -     #     # Iterator handle
    # limit: Number<Optional> -     #     # Maximum count of the returned items.    #     # If value is missing or is less than 1 the library uses 1.
    # return_resume_state: Boolean<Optional> -     #     # Indicates that function must return the iterator state that can be used for resuming iteration.
    # RESPONSE: ResultOfIteratorNext
    # items: Array -     #     # Next available items.    #     # Note that `iterator_next` can return an empty items and `has_more` equals to `true`.
    # In this case the application have to continue iteration.
    # Such situation can take place when there is no data yet butthe requested `end_time` is not reached.
    # has_more: Boolean -     #     # Indicates that there are more available items in iterated range.
    # resume_state: Value<Optional> -     #     # Optional iterator state that can be used for resuming iteration.    #     # This field is returned only if the `return_resume_state` parameteris specified.
    # Note that `resume_state` corresponds to the iteration positionafter the returned items.
    # Async
    def iterator_next(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def iterator_next_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

    # INPUT: RegisteredIterator
    # handle: Number -     #     # Iterator handle.    #     # Must be removed using `remove_iterator`when it is no more needed for the application.
    # Async
    def remove_iterator(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def remove_iterator_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

    # RESPONSE: ResultOfGetSignatureId
    # signature_id: Number<Optional> -     #     # Signature ID for configured network if it should be used in messages signature
    # Async
    def get_signature_id(&block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: {}, &block)
    end

    # Sync
    def get_signature_id_sync()
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: {})
    end

  end
end

