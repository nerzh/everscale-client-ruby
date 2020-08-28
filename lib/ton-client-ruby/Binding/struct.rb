module TonClient
  module TonBinding
    
    # pub struct InteropString {
    #     pub content: *const u8,
    #     pub len: u32,
    # }
    class InteropString < FFI::Struct
      layout :content, :pointer,
        :len, :uint32
    end

    # pub struct JsonResponse {
    #   pub result_json: String,
    #   pub error_json: String,
    # }
    class JsonResponse < FFI::Struct
      layout :result_json, :string,
        :error_json, :string
    end

    # pub struct InteropJsonResponse {
    #   pub result_json: InteropString,
    #   pub error_json: InteropString,
    # }
    class InteropJsonResponse < FFI::Struct
      layout :result_json, InteropString,
        :error_json, InteropString
    end
  end
end