module TonClient

  class Proofs
    include CommonInstanceHelpers

    attr_reader :context
    MODULE = self.to_s.downcase.gsub(/^(.+::|)(\w+)$/, '\2').freeze

    def initialize(context: nil)
      @context = context
    end

    # INPUT: ParamsOfProofBlockData
    # block: Value -     #     # Single block's data, retrieved from TONOS API, that needs proof. Required fields are `id` and/or top-level `boc` (for block identification), others are optional.
    def proof_block_data(payload, &block)
      TonBinding.requestLibrary(context: context, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfProofTransactionData
    # transaction: Value -     #     # Single transaction's data as queried from DApp server, without modifications. The required fields are `id` and/or top-level `boc`, others are optional. In order to reduce network requests count, it is recommended to provide `block_id` and `boc` of transaction.
    def proof_transaction_data(payload, &block)
      TonBinding.requestLibrary(context: context, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfProofMessageData
    # message: Value -     #     # Single message's data as queried from DApp server, without modifications. The required fields are `id` and/or top-level `boc`, others are optional. In order to reduce network requests count, it is recommended to provide at least `boc` of message and non-null `src_transaction.id` or `dst_transaction.id`.
    def proof_message_data(payload, &block)
      TonBinding.requestLibrary(context: context, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

  end
end

