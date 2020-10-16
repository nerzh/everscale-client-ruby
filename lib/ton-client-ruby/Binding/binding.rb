module TonClient
  
  module TonBinding
    extend FFI::Library
    
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

      # enum tc_response_types_t {
      #     tc_response_success = 0,
      #     tc_response_error = 1,
      #     tc_response_nop = 2,
      #     tc_response_custom = 100,
      # };
      # typedef void (*tc_response_handler_t)(
      #   uint32_t request_id,
      #   tc_string_data_t params_json,
      #   uint32_t response_type,
      #   bool finished);
      callback :tc_response_handler_t, [:uint32, TcStringDataT.by_value, :uint32, :bool], :void

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

    def self.read_string_to_hash(tc_string_handle_t_ref)
      json_string = read_string(tc_string_handle_t_ref)
      JSON.parse(json_string) if json_string
    end

    def self.send_request(context: 1, method_name: '', payload: {}, request_id: 1, &block)
      raise 'context not found' unless context
      raise 'method_name is empty' if method_name.empty?

      if block
        method_name_string = make_string(method_name)
        payload_string = make_string(payload.to_json)

        tc_request(context, method_name_string, payload_string, request_id, &block)
      end
    end

    def self.send_request_sync(context: 1, method_name: '', payload: {})
      raise 'context not found' unless context
      raise 'method_name is empty' if method_name.empty?

      method_name_string = make_string(method_name)
      payload_string = make_string(payload.to_json)

      sdk_json_response = tc_request_sync(context, method_name_string, payload_string)
      response = read_string_to_hash(sdk_json_response)
      
      return response['result'] if response['result']
      return response['error'] if response['error']
    end
  end
end







