module TonClient

  class Client
    include CommonInstanceHelpers

    attr_reader :context, :context_config, :request_id, :requests, :monitor
    private_accessor :_crypto, :_abi, :_boc, :_processing, :_utils, :_tvm, :_net, :_debot, :_proofs
    MODULE = self.to_s.downcase.gsub(/^(.+::|)(\w+)$/, '\2').freeze

    def initialize(context_config: {})
      @context_config = context_config
      @request_id = RequestId.new
      @requests = Requests.new
      @monitor = Monitor.new
      config = TonBinding.make_string(context_config.to_json)
      context_ptr = TonBinding.tc_create_context(config)
      context_response = TonBinding.read_string_data_ref(context_ptr)
      @context = TonBinding.read_string_to_hash(context_response)['result']
      ObjectSpace.define_finalizer(self, self.class.finalize(@context))
    end

    def self.finalize(ctx)
      Proc.new do
        if (ctx != nil) && (ctx > 0)
          TonBinding.tc_destroy_context(ctx)
        end
      end
    end

    def crypto
      _crypto ||= Crypto.new(context: context, request_id: request_id, requests: requests, monitor: monitor)
    end

    def abi
      _abi ||= Abi.new(context: context, request_id: request_id, requests: requests, monitor: monitor)
    end

    def boc
      _boc ||= Boc.new(context: context, request_id: request_id, requests: requests, monitor: monitor)
    end

    def processing
      _processing ||= Processing.new(context: context, request_id: request_id, requests: requests, monitor: monitor)
    end

    def utils
      _utils ||= Utils.new(context: context, request_id: request_id, requests: requests, monitor: monitor)
    end

    def tvm
      _tvm ||= Tvm.new(context: context, request_id: request_id, requests: requests, monitor: monitor)
    end

    def net
      _net ||= Net.new(context: context, request_id: request_id, requests: requests, monitor: monitor)
    end

    def debot
      _debot ||= Debot.new(context: context, request_id: request_id, requests: requests, monitor: monitor)
    end

    def proofs
      _proofs ||= Proofs.new(context: context, request_id: request_id, requests: requests, monitor: monitor)
    end

    # RESPONSE: ResultOfGetApiReference
    # api: Value - 
    # Async
    def get_api_reference(&block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: {}, &block)
    end

    # Sync
    def get_api_reference_sync()
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: {})
    end

    # RESPONSE: ResultOfVersion
    # version: String -     #     # Core Library version
    # Async
    def version(&block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: {}, &block)
    end

    # Sync
    def version_sync()
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: {})
    end

    # RESPONSE: ClientConfig
    # binding: BindingConfig<Optional> - 
    # network: NetworkConfig<Optional> - 
    # crypto: CryptoConfig<Optional> - 
    # abi: Value - 
    # boc: BocConfig<Optional> - 
    # proofs: ProofsConfig<Optional> - 
    # local_storage_path: String<Optional> -     #     # For file based storage is a folder name where SDK will store its data. For browser based is a browser async storage key prefix. Default (recommended) value is "~/.tonclient" for native environments and ".tonclient" for web-browser.
    # Async
    def config(&block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: {}, &block)
    end

    # Sync
    def config_sync()
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: {})
    end

    # RESPONSE: ResultOfBuildInfo
    # build_number: Number -     #     # Build number assigned to this build by the CI.
    # dependencies: Array -     #     # Fingerprint of the most important dependencies.
    # Async
    def build_info(&block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: {}, &block)
    end

    # Sync
    def build_info_sync()
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: {})
    end

    # INPUT: ParamsOfResolveAppRequest
    # app_request_id: Number -     #     # Request ID received from SDK
    # result: AppRequestResult -     #     # Result of request processing
    # Async
    def resolve_app_request(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # Sync
    def resolve_app_request_sync(payload)
      TonBinding.send_request_sync(context: context, method_name: full_method_name(MODULE, __method__.to_s).sub(/_sync$/, ''), payload: payload)
    end

  end
end

