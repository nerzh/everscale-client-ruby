module TonClient
  
  module TonBinding
    extend FFI::Library
    # ffi_lib '/Users/nerzh/mydata/trash/ton/TON-SDK/target/debug/libton_client.' + FFI::Platform::LIBSUFFIX
    
    def self.setup_bindings
      typedef :uint32, :InteropContext
      
      # fn tc_create_context() -> InteropContext
      attach_function :tc_create_context, [], :InteropContext

      # fn tc_destroy_context(context: InteropContext)
      attach_function :tc_destroy_context, [:InteropContext], :void
      
      # fn tc_json_request_async(
      #   context: InteropContext,
      #   method_name: InteropString,
      #   params_json: InteropString,
      #   request_id: i32,
      #   on_result: OnResult,
      # )
      # attach_function :tc_json_request_async, 

      # pub unsafe extern "C" fn tc_json_request(
      # context: InteropContext,
      # method_name: InteropString,
      # params_json: InteropString,
      # ) -> *const JsonResponse
      attach_function :tc_json_request, [:InteropContext, InteropString.by_value, InteropString.by_value], JsonResponse.by_ref

      # fn tc_read_json_response(
      #   response: *const JsonResponse
      # ) -> InteropJsonResponse
      attach_function :tc_read_json_response, [JsonResponse.by_ref], InteropJsonResponse.by_value
    end

    def self.send_request(context: nil, method_name: '', payload: {})
      raise 'context not found' unless context
      raise 'method_name is empty' if method_name.empty?
      json = payload.to_json

      method_name_pointer = FFI::MemoryPointer.from_string(method_name)
      method_name_string = TonBinding::InteropString.new
      method_name_string[:content] = method_name_pointer
      method_name_string[:len] = method_name.bytesize

      json_pointer = FFI::MemoryPointer.from_string(json)
      json_string = TonBinding::InteropString.new
      json_string[:content] = json_pointer
      json_string[:len] = json.bytesize

      sdk_json_response = TonBinding.tc_json_request(context, method_name_string, json_string)
      sdk_json = TonBinding.tc_read_json_response(sdk_json_response)
      
      if sdk_json[:result_json][:content].address > 1
        json_content = sdk_json[:result_json][:content].read_string(sdk_json[:result_json][:len])
        return JSON.parse(json_content)
      end
      if sdk_json[:error_json][:content].address > 1
        json_error = sdk_json[:error_json][:content].read_string(sdk_json[:error_json][:len])
        return JSON.parse(json_error)
      end
    end
  end
end







