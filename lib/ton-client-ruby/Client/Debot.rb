module TonClient

  class Debot
    include CommonInstanceHelpers

    attr_reader :core, :context
    MODULE = self.to_s.downcase.gsub(/^(.+::|)(\w+)$/, '\2').freeze

    def initialize(context: Context.new, core: TonClient::TonBinding)
      @context = context
      @core = core
    end

    # INPUT: TSDKParamsOfInit
    # address: String -     # Debot smart contract address
    # RESPONSE: TSDKRegisteredDebot
    # debot_handle: TSDKDebotHandle -     # Debot handle which references an instance of debot engine.
    # debot_abi: String -     # Debot abi as json string.
    # info: TSDKDebotInfo -     # Debot metadata.
    def init(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: TSDKParamsOfStart
    # debot_handle: TSDKDebotHandle -     # Debot handle which references an instance of debot engine.
    def start(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: TSDKParamsOfFetch
    # address: String -     # Debot smart contract address.
    # RESPONSE: TSDKResultOfFetch
    # info: TSDKDebotInfo -     # Debot metadata.
    def fetch(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: TSDKParamsOfExecute
    # debot_handle: TSDKDebotHandle -     # Debot handle which references an instance of debot engine.
    # action: TSDKDebotAction -     # Debot Action that must be executed.
    def execute(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: TSDKParamsOfSend
    # debot_handle: TSDKDebotHandle -     # Debot handle which references an instance of debot engine.
    # message: String -     # BOC of internal message to debot encoded in base64 format.
    def send(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: TSDKParamsOfRemove
    # debot_handle: TSDKDebotHandle -     # Debot handle which references an instance of debot engine.
    def remove(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

  end
end

