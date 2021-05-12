module TonClient

  class Tvm
    include CommonInstanceHelpers

    attr_reader :core, :context
    MODULE = self.to_s.downcase.gsub(/^(.+::|)(\w+)$/, '\2').freeze

    def initialize(context: Context.new, core: TonClient::TonBinding)
      @context = context
      @core = core
    end

    # INPUT: TSDKParamsOfRunExecutor
    # message: String -     # Input message BOC.    # Must be encoded as base64.
    # account: TSDKAccountForExecutor -     # Account to run on executor
    # execution_options: TSDKExecutionOptions -     # Execution options.
    # abi: TSDKAbi -     # Contract ABI for decoding output messages
    # skip_transaction_check: Boolean -     # Skip transaction check flag
    # boc_cache: TSDKBocCacheType -     # Cache type to put the result.    # The BOC itself returned if no cache type provided
    # return_updated_account: Boolean -     # Return updated account flag.    # Empty string is returned if the flag is `false`
    # RESPONSE: TSDKResultOfRunExecutor
    # transaction: Value -     # Parsed transaction.    # In addition to the regular transaction fields there is a`boc` field encoded with `base64` which contains sourcetransaction BOC.
    # out_messages: Array -     # List of output messages' BOCs.    # Encoded as `base64`
    # decoded: TSDKDecodedOutput -     # Optional decoded message bodies according to the optional `abi` parameter.
    # account: String -     # Updated account state BOC.    # Encoded as `base64`
    # fees: TSDKTransactionFees -     # Transaction fees
    def run_executor(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: TSDKParamsOfRunTvm
    # message: String -     # Input message BOC.    # Must be encoded as base64.
    # account: String -     # Account BOC.    # Must be encoded as base64.
    # execution_options: TSDKExecutionOptions -     # Execution options.
    # abi: TSDKAbi -     # Contract ABI for decoding output messages
    # boc_cache: TSDKBocCacheType -     # Cache type to put the result.    # The BOC itself returned if no cache type provided
    # return_updated_account: Boolean -     # Return updated account flag.    # Empty string is returned if the flag is `false`
    # RESPONSE: TSDKResultOfRunTvm
    # out_messages: Array -     # List of output messages' BOCs.    # Encoded as `base64`
    # decoded: TSDKDecodedOutput -     # Optional decoded message bodies according to the optional `abi` parameter.
    # account: String -     # Updated account state BOC.    # Encoded as `base64`. Attention! Only `account_state.storage.state.data` part of the BOC is updated.
    def run_tvm(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: TSDKParamsOfRunGet
    # account: String -     # Account BOC in `base64`
    # function_name: String -     # Function name
    # input: Value -     # Input parameters
    # execution_options: TSDKExecutionOptions -     # Execution options
    # tuple_list_as_array: Boolean -     # Convert lists based on nested tuples in the **result** into plain arrays.    # Default is `false`. Input parameters may use any of lists representationsIf you receive this error on Web: "Runtime error. Unreachable code should not be executed...",set this flag to true.This may happen, for example, when elector contract contains too many participants
    # RESPONSE: TSDKResultOfRunGet
    # output: Value -     # Values returned by get-method on stack
    def run_get(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

  end
end

