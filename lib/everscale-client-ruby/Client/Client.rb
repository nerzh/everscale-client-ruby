module TonClient

  class Client
    include CommonInstanceHelpers

    attr_reader :core, :context
    private_accessor :_crypto, :_abi, :_boc, :_processing, :_utils, :_tvm, :_net, :_debot, :_proofs
    MODULE = self.to_s.downcase.gsub(/^(.+::|)(\w+)$/, '\2').freeze

    def initialize(context: Context.new, core: TonClient::TonBinding)
      @context = context
      @core = core
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

    def processing
      _processing ||= Processing.new(context: context)
    end

    def utils
      _utils ||= Utils.new(context: context)
    end

    def tvm
      _tvm ||= Tvm.new(context: context)
    end

    def net
      _net ||= Net.new(context: context)
    end

    def debot
      _debot ||= Debot.new(context: context)
    end

    def proofs
      _proofs ||= Proofs.new(context: context)
    end

    # RESPONSE: ResultOfGetApiReference
    # api: Value - 
    def get_api_reference(&block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: {}, &block)
    end

    # RESPONSE: ResultOfVersion
    # version: String -     #     # Core Library version
    def version(&block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: {}, &block)
    end

    # RESPONSE: ClientConfig
    # network: NetworkConfig<Optional> - 
    # crypto: CryptoConfig<Optional> - 
    # abi: Value - 
    # boc: BocConfig<Optional> - 
    # proofs: ProofsConfig<Optional> - 
    # local_storage_path: String<Optional> -     #     # For file based storage is a folder name where SDK will store its data. For browser based is a browser async storage key prefix. Default (recommended) value is "~/.tonclient" for native environments and ".tonclient" for web-browser.
    def config(&block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: {}, &block)
    end

    # RESPONSE: ResultOfBuildInfo
    # build_number: Number -     #     # Build number assigned to this build by the CI.
    # dependencies: Array -     #     # Fingerprint of the most important dependencies.
    def build_info(&block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: {}, &block)
    end

    # INPUT: ParamsOfResolveAppRequest
    # app_request_id: Number -     #     # Request ID received from SDK
    # result: AppRequestResult -     #     # Result of request processing
    def resolve_app_request(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

  end
end

