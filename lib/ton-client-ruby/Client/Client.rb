module TonClient
  
  class Client

    attr_reader :context, :core

    def initialize(context: Context.new, core: TonClient::TonBinding)
      @context = context
      @core = core
    end

    def version
      core.send_request_sync(context: context, method_name: 'version')
    end
  end
end


module TonClient
  
  class Client

  end
end
