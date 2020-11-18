module TonClient
  class Context
    
    attr_reader :id

    def initialize(config: {})
      TonClient.check_configuration
      @config = TonBinding.make_string(config.to_json)
      context = TonBinding.tc_create_context(@config)
      @id = TonBinding.read_string_to_hash(context)['result']
    end

    def config=(value = {})
      @config = TonBinding.make_string(value.to_json)
    end

    def config
      TonBinding.read_string_to_hash(@config)
    end

    def destroy
      TonBinding.tc_destroy_context(id)
    end

    def self.finalize
      TonBinding.tc_destroy_context(id)
    end
  end
end
