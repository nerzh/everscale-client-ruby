module TonClient
  module TonBinding
    
    # typedef struct {
    #     const char* content;
    #     uint32_t len;
    # } tc_string_data_t;
    class TcStringDataT < FFI::Struct
      layout :content, :pointer,
        :len, :uint32
    end
  end
end