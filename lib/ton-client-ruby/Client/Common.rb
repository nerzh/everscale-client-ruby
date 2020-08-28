module TonClient
  
  class Common

    attr_reader :context, :core

    def initialize(context: TonClient.context, core: TonClient::TonBinding)
      @context = context
      @core = core
    end

    def version
      core.send_request(context: context, method_name: 'version')
    end

    def setup(payload = {network: ["net.ton.dev"]})
      core.send_request(context: context, method_name: 'setup', payload: payload)
    end
  end
end
