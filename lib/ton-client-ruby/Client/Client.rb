module TonClient
  
  class Client
    include CommonInstanceHelpers

    attr_reader :core, :context
    private_accessor :_crypto, :_abi, :_boc, :_net, :_processing, :_tvm, :_utils
    MODULE = 'client'.freeze

    def initialize(context: Context.new, core: TonClient::TonBinding)
      @context = context
      @core = core
    end

    def version(&block)
      method_name = "version"
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, method_name), payload: {}, &block)
    end

    def get_api_reference(&block)
      method_name = "get_api_reference"
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, method_name), payload: {}, &block)
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