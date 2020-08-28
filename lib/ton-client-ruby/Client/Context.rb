module TonClient
  class Context
    attr_reader :interop_context

    def initialize
      interop_context = TonBinding.tc_create_context()
    end

    def destroy
      TonBinding.tc_destroy_context(interop_context)
    end

    def self.finalize(bar)
      TonBinding.tc_destroy_context(interop_context)
    end
  end
end
