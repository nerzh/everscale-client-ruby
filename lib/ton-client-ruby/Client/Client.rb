module TonClient
  
  class Client
    include CommonInstanceHelpers

    attr_reader :core, :context
    private_accessor :_crypto, :_abi, :_boc, :_net, :_processing, :_tvm, :_utils
    MODULE = self.to_s.downcase.gsub(/^(.+::|)(\w+)$/, '\2').freeze

    def initialize(context: Context.new, core: TonClient::TonBinding)
      @context = context
      @core = core
    end

    def version(&block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: {}, &block)
    end

    def get_api_reference(&block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: {}, &block)
    end

    def build_info(&block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: {}, &block)
    end

    def resolve_app_request(&block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: {}, &block)
    end

    def destroy_context
      core.tc_destroy_context(context.id)
    end

    def crypto
      _crypto ||= Crypto.new(context: context)
    end

    def abi
      _abi ||= Abi.new(context: context)
    end

    def boc
      _boc ||= Boc.new(context: context)
    end

    def net
      _net ||= Net.new(context: context)
    end

    def processing
      _processing ||= Processing.new(context: context)
    end

    def tvm
      _tvm ||= Tvm.new(context: context)
    end

    def utils
      _utils ||= Utils.new(context: context)
    end
  end
end