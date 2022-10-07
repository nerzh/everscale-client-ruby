module TonClient

  class Tvm
    include CommonInstanceHelpers
    @@sm = Concurrent::Semaphore.new(1)
    
    attr_reader :context, :request_id, :requests
    MODULE = self.to_s.downcase.gsub(/^(.+::|)(\w+)$/, '\2').freeze

    def initialize(context: nil, request_id: nil, requests: nil)
      @context = context; @request_id = request_id; @requests = requests
    end

    # INPUT: ParamsOfRunExecutor
    # message: String -     #     # Input message BOC.    #     # Must be encoded as base64.
    # account: AccountForExecutor -     #     # Account to run on executor
    # execution_options: ExecutionOptions<Optional> -     #     # Execution options.
    # abi: Value<Optional> -     #     # Contract ABI for decoding output messages
    # skip_transaction_check: Boolean<Optional> -     #     # Skip transaction check flag
    # boc_cache: BocCacheType<Optional> -     #     # Cache type to put the result.    #     # The BOC itself returned if no cache type provided
    # return_updated_account: Boolean<Optional> -     #     # Return updated account flag.    #     # Empty string is returned if the flag is `false`
    # RESPONSE: ResultOfRunExecutor
    # transaction: Value -     #     # Parsed transaction.    #     # In addition to the regular transaction fields there is a`boc` field encoded with `base64` which contains sourcetransaction BOC.
    # out_messages: Array -     #     # List of output messages' BOCs.    #     # Encoded as `base64`
    # decoded: DecodedOutput<Optional> -     #     # Optional decoded message bodies according to the optional `abi` parameter.
    # account: String -     #     # Updated account state BOC.    #     # Encoded as `base64`
    # fees: TransactionFees -     #     # Transaction fees
    def run_executor(payload, &block)
      TonBinding.requestLibrary(context: context, sm: @@sm, request_id: request_id, requests: requests, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfRunTvm
    # message: String -     #     # Input message BOC.    #     # Must be encoded as base64.
    # account: String -     #     # Account BOC.    #     # Must be encoded as base64.
    # execution_options: ExecutionOptions<Optional> -     #     # Execution options.
    # abi: Value<Optional> -     #     # Contract ABI for decoding output messages
    # boc_cache: BocCacheType<Optional> -     #     # Cache type to put the result.    #     # The BOC itself returned if no cache type provided
    # return_updated_account: Boolean<Optional> -     #     # Return updated account flag.    #     # Empty string is returned if the flag is `false`
    # RESPONSE: ResultOfRunTvm
    # out_messages: Array -     #     # List of output messages' BOCs.    #     # Encoded as `base64`
    # decoded: DecodedOutput<Optional> -     #     # Optional decoded message bodies according to the optional `abi` parameter.
    # account: String -     #     # Updated account state BOC.    #     # Encoded as `base64`. Attention! Only `account_state.storage.state.data` part of the BOC is updated.
    def run_tvm(payload, &block)
      TonBinding.requestLibrary(context: context, sm: @@sm, request_id: request_id, requests: requests, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfRunGet
    # account: String -     #     # Account BOC in `base64`
    # function_name: String -     #     # Function name
    # input: Value -     #     # Input parameters
    # execution_options: ExecutionOptions<Optional> -     #     # Execution options
    # tuple_list_as_array: Boolean<Optional> -     #     # Convert lists based on nested tuples in the **result** into plain arrays.    #     # Default is `false`. Input parameters may use any of lists representationsIf you receive this error on Web: "Runtime error. Unreachable code should not be executed...",set this flag to true.
    # This may happen, for example, when elector contract contains too many participants
    # RESPONSE: ResultOfRunGet
    # output: Value -     #     # Values returned by get-method on stack
    def run_get(payload, &block)
      TonBinding.requestLibrary(context: context, sm: @@sm, request_id: request_id, requests: requests, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

  end
end

