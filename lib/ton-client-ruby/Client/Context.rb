module TonClient
  class Context
    include TonClient
    attr_reader :id, :config

    def initialize(config: {})
      TonClient.check_configuration
      @config = TonBinding.make_string(config.to_json)
      context = TonBinding.tc_create_context(@config)
      @id = TonBinding.read_string_to_json(context)['result']
    end

    def destroy
      TonBinding.tc_destroy_context(id)
    end

    def self.finalize
      TonBinding.tc_destroy_context(id)
    end
  end
end
