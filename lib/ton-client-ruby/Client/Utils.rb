module TonClient
  
  class Utils
    include CommonInstanceHelpers

    attr_reader :core, :context
    MODULE = 'utils'.freeze

    def initialize(context: Context.new, core: TonClient::TonBinding)
      @context = context
      @core = core
    end

    def convert_address(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end
  end
end






