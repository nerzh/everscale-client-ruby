module TonClient
  
  module TonBinding
    extend FFI::Library
    # ffi_lib '/Users/nerzh/mydata/trash/ton/TON-SDK/target/debug/libton_client.' + FFI::Platform::LIBSUFFIX
    
    def self.setup_bindings
      typedef :uint32, :InteropContext
      
      # fn tc_create_context() -> InteropContext
      # attach_function :tc_create_context, [], :InteropContext

      # tc_string_handle_t* tc_create_context(tc_string_data_t config);
      attach_function :tc_create_context, [TcStringDataT.by_value], TcStringHandleT.by_ref

      # fn tc_destroy_context(context: InteropContext)
      attach_function :tc_destroy_context, [:InteropContext], :void

      # tc_string_handle_t* tc_request_sync(
      #   uint32_t context,
      #   tc_string_data_t function_name,
      #   tc_string_data_t function_params_json);
      attach_function :tc_request_sync, [:InteropContext, TcStringDataT.by_value, TcStringDataT.by_value], TcStringHandleT.by_ref

      # typedef void (*tc_response_handler_t)(
      #   uint32_t request_id,
      #   tc_string_data_t params_json,
      #   uint32_t response_type,
      #   bool finished);
      callback :tc_response_handler_t, [:uint32, :uint32, TcStringDataT.by_value, :bool], :void

      # void tc_request(
      #   uint32_t context,
      #   tc_string_data_t function_name,
      #   tc_string_data_t function_params_json,
      #   uint32_t request_id,
      #   tc_response_handler_t response_handler);
      attach_function :tc_request, [:InteropContext, TcStringDataT.by_value, TcStringDataT.by_value, :uint32, :tc_response_handler_t], :void

      # tc_string_data_t tc_read_string(const tc_string_handle_t* handle);
      attach_function :tc_read_string, [TcStringHandleT.by_ref], TcStringDataT.by_value

      # void tc_destroy_string(const tc_string_handle_t* handle)
      attach_function :tc_destroy_string, [TcStringHandleT.by_ref], :void

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
      # attach_function :tc_json_request, [:InteropContext, InteropString.by_value, InteropString.by_value], JsonResponse.by_ref

      # fn tc_read_json_response(
      #   response: *const JsonResponse
      # ) -> InteropJsonResponse
      # attach_function :tc_read_json_response, [JsonResponse.by_ref], InteropJsonResponse.by_value
    end

    def self.make_string(string)
      string_pointer = FFI::MemoryPointer.from_string(string)
      result = TonBinding::TcStringDataT.new
      result[:content] = string_pointer
      result[:len] = string.bytesize
      result
    end

    def self.read_string(tc_string_handle_t_ref)
      string = tc_read_string(tc_string_handle_t_ref)
      if string[:content].address > 1
        string = string[:content].read_string(string[:len])
        tc_destroy_string(tc_string_handle_t_ref)
        return string
      end
      nil
    end

    def self.read_string_to_json(tc_string_handle_t_ref)
      json_string = read_string(tc_string_handle_t_ref)
      JSON.parse(json_string) if json_string
    end

    def self.send_request(context: nil, method_name: '', payload: {})
      # raise 'context not found' unless context
      # raise 'method_name is empty' if method_name.empty?
      # json = payload.to_json

      # method_name_pointer = FFI::MemoryPointer.from_string(method_name)
      # method_name_string = TonBinding::InteropString.new
      # method_name_string[:content] = method_name_pointer
      # method_name_string[:len] = method_name.bytesize

      # json_pointer = FFI::MemoryPointer.from_string(json)
      # json_string = TonBinding::InteropString.new
      # json_string[:content] = json_pointer
      # json_string[:len] = json.bytesize

      # sdk_json_response = TonBinding.tc_json_request(context, method_name_string, json_string)
      # sdk_json = TonBinding.tc_read_json_response(sdk_json_response)
      
      # if sdk_json[:result_json][:content].address > 1
      #   json_content = sdk_json[:result_json][:content].read_string(sdk_json[:result_json][:len])
      #   return JSON.parse(json_content)
      # end
      # if sdk_json[:error_json][:content].address > 1
      #   json_error = sdk_json[:error_json][:content].read_string(sdk_json[:error_json][:len])
      #   return JSON.parse(json_error)
      # end
    end

    def self.send_request_sync(context: nil, method_name: '', payload: {})
      # raise 'context not found' unless context
      # raise 'method_name is empty' if method_name.empty?
      # json = payload.to_json

      # method_name_pointer = FFI::MemoryPointer.from_string(method_name)
      # method_name_string = TonBinding::InteropString.new
      # method_name_string[:content] = method_name_pointer
      # method_name_string[:len] = method_name.bytesize

      # json_pointer = FFI::MemoryPointer.from_string(json)
      # json_string = TonBinding::InteropString.new
      # json_string[:content] = json_pointer
      # json_string[:len] = json.bytesize

      # sdk_json_response = TonBinding.tc_json_request(context, method_name_string, json_string)
      # sdk_json = TonBinding.tc_read_json_response(sdk_json_response)
      
      # if sdk_json[:result_json][:content].address > 1
      #   json_content = sdk_json[:result_json][:content].read_string(sdk_json[:result_json][:len])
      #   return JSON.parse(json_content)
      # end
      # if sdk_json[:error_json][:content].address > 1
      #   json_error = sdk_json[:error_json][:content].read_string(sdk_json[:error_json][:len])
      #   return JSON.parse(json_error)
      # end
    end
  end
end







