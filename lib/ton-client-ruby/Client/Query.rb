module TonClient
  
  class Query

    attr_reader :context, :core

    def initialize(context: Context.new, core: TonClient::TonBinding)
      @context = context.id
      @core = core
    end

    # payload = {
    #     filter: any,
    #     result: string,
    #     orderBy?: OrderBy[],
    #     limit?: number,
    #     timeout?: number,
    #     operationId?: string,
    # }
    def run(payload)
      core.send_request(context: context, method_name: 'contracts.run', payload: payload)
    end

  end
end
