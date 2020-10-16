module TonClient
  
  class Client

    attr_accessor :context
    attr_reader :core
    private_accessor :_crypto
    MODULE = 'client'.freeze


    def initialize(context: Context.new, core: TonClient::TonBinding)
      @context = context
      @core = core
    end

    def version
      method_name = "version"
      full_method_name = "#{MODULE}.#{method_name}"
      if block_given?
        core.send_request(context: context.id, method_name: full_method_name, request_id: 999) do |request_id, data, response_type, finished|
          yield(request_id, data, response_type, finished)
        end
      else
        core.send_request_sync(context: context.id, method_name: full_method_name)['version']
      end
    end

    def destroy_context
      core.tc_destroy_context(context.id)
    end

    def crypto
      _crypto ||= Crypto.new(context: context)
      _crypto.context = context
      _crypto
    end
  end
end