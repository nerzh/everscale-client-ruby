module TonClient
  module TonBinding
    
    # typedef struct {
    #     const char* content;
    #     uint32_t len;
    # } tc_string_data_t;
    class TcStringDataT < FFI::Struct
      layout :content, :pointer,
        :len, :uint32

      # def initialize(*args)
      #   super
      #   ObjectSpace.define_finalizer(self, self.class.finalize(@content))
      # end
      #
      # def self.finalize(ctx)
      #   Proc.new do
      #     if ctx != nil
      #       TonBinding.free(ctx)
      #     end
      #   end
      # end
    end
  end
end