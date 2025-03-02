module TonClient

  class Processing
    include CommonInstanceHelpers

    attr_reader :context, :request_id, :requests, :monitor
    MODULE = self.to_s.downcase.gsub(/^(.+::|)(\w+)$/, '\2').freeze

    def initialize(context: nil, request_id: nil, requests: nil, monitor: nil)
      @context = context
      @request_id = request_id
      @requests = requests
      @monitor = monitor
    end

    # INPUT: ParamsOfMonitorMessages
    # queue: String -     #     # Name of the monitoring queue.
    # messages: Array -     #     # Messages to start monitoring for.
    # Async
    def monitor_messages(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def monitor_messages_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

    # INPUT: ParamsOfGetMonitorInfo
    # queue: String -     #     # Name of the monitoring queue.
    # RESPONSE: MonitoringQueueInfo
    # unresolved: Number -     #     # Count of the unresolved messages.
    # resolved: Number -     #     # Count of resolved results.
    # Async
    def get_monitor_info(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def get_monitor_info_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

    # INPUT: ParamsOfFetchNextMonitorResults
    # queue: String -     #     # Name of the monitoring queue.
    # wait_mode: MonitorFetchWaitMode<Optional> -     #     # Wait mode.    #     # Default is `NO_WAIT`.
    # RESPONSE: ResultOfFetchNextMonitorResults
    # results: Array -     #     # List of the resolved results.
    # Async
    def fetch_next_monitor_results(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def fetch_next_monitor_results_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

    # INPUT: ParamsOfCancelMonitor
    # queue: String -     #     # Name of the monitoring queue.
    # Async
    def cancel_monitor(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def cancel_monitor_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

    # INPUT: ParamsOfSendMessages
    # messages: Array -     #     # Messages that must be sent to the blockchain.
    # monitor_queue: String<Optional> -     #     # Optional message monitor queue that starts monitoring for the processing results for sent messages.
    # RESPONSE: ResultOfSendMessages
    # messages: Array -     #     # Messages that was sent to the blockchain for execution.
    # Async
    def send_messages(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def send_messages_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

    # INPUT: ParamsOfSendMessage
    # message: String -     #     # Message BOC.
    # abi: Value<Optional> -     #     # Optional message ABI.    #     # If this parameter is specified and the message has the`expire` header then expiration time will be checked againstthe current time to prevent unnecessary sending of already expired message.
    # The `message already expired` error will be returned in thiscase.
    # Note, that specifying `abi` for ABI compliant contracts isstrongly recommended, so that proper processing strategy can bechosen.
    # send_events: Boolean -     #     # Flag for requesting events sending
    # RESPONSE: ResultOfSendMessage
    # shard_block_id: String -     #     # The last generated shard block of the message destination account before the message was sent.    #     # This block id must be used as a parameter of the`wait_for_transaction`.
    # sending_endpoints: Array -     #     # The list of endpoints to which the message was sent.    #     # This list id must be used as a parameter of the`wait_for_transaction`.
    # Async
    def send_message(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def send_message_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

    # INPUT: ParamsOfWaitForTransaction
    # abi: Value<Optional> -     #     # Optional ABI for decoding the transaction result.    #     # If it is specified, then the output messages' bodies will bedecoded according to this ABI.
    # The `abi_decoded` result field will be filled out.
    # message: String -     #     # Message BOC.    #     # Encoded with `base64`.
    # shard_block_id: String -     #     # The last generated block id of the destination account shard before the message was sent.    #     # You must provide the same value as the `send_message` has returned.
    # send_events: Boolean -     #     # Flag that enables/disables intermediate events
    # sending_endpoints: Array<Optional> -     #     # The list of endpoints to which the message was sent.    #     # Use this field to get more informative errors.
    # Provide the same value as the `send_message` has returned.
    # If the message was not delivered (expired), SDK will log the endpoint URLs, used for its sending.
    # RESPONSE: ResultOfProcessMessage
    # transaction: Value -     #     # Parsed transaction.    #     # In addition to the regular transaction fields there is a`boc` field encoded with `base64` which contains sourcetransaction BOC.
    # out_messages: Array -     #     # List of output messages' BOCs.    #     # Encoded as `base64`
    # decoded: DecodedOutput<Optional> -     #     # Optional decoded message bodies according to the optional `abi` parameter.
    # fees: TransactionFees -     #     # Transaction fees
    # Async
    def wait_for_transaction(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def wait_for_transaction_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

    # INPUT: ParamsOfProcessMessage
    # message_encode_params: ParamsOfEncodeMessage -     #     # Message encode parameters.
    # send_events: Boolean -     #     # Flag for requesting events sending
    # RESPONSE: ResultOfProcessMessage
    # transaction: Value -     #     # Parsed transaction.    #     # In addition to the regular transaction fields there is a`boc` field encoded with `base64` which contains sourcetransaction BOC.
    # out_messages: Array -     #     # List of output messages' BOCs.    #     # Encoded as `base64`
    # decoded: DecodedOutput<Optional> -     #     # Optional decoded message bodies according to the optional `abi` parameter.
    # fees: TransactionFees -     #     # Transaction fees
    # Async
    def process_message(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def process_message_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

  end
end

