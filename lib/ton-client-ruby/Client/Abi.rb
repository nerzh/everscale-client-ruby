module TonClient
  
  class Abi
    include CommonInstanceHelpers

    attr_reader :core, :context
    MODULE = 'abi'.freeze

    def initialize(context: Context.new, core: TonClient::TonBinding)
      @context = context
      @core = core
    end

    def encode_message(&block)
      method_name = "encode_message"
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, method_name), payload: {}, &block)
    end
    
  end
end