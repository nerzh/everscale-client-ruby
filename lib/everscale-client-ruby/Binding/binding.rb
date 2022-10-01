require 'byebug'

module TonClient
  module TonBinding
    @@request_id = Concurrent::AtomicFixnum.new(1)
    @@requests = Concurrent::Hash.new()

    class Response
      attr_reader :core
      attr_accessor :result, :error, :custom_response, :finished, :request_id, :current_response

      def initialize(core: TonBinding)
        @core = core
      end

      def update(request_id, string_data, response_type, finished)
        response_hash = core.read_string_to_hash(string_data)
        self.finished = finished
        self.request_id = request_id
        self.current_response = response_hash
        
        case response_type
        when 0
          # result
          self.result = response_hash
        when 1
          # error
          self.error = response_hash
        else
          # another
          if response_type >= 100
            self.custom_responses = response_hash
          end
        end
      end
    end

    def self.generate_request_id
      @@request_id.increment()
      @@request_id.value
    end

    def self.get_request(id)
      @@requests[id]
    end

    def self.set_request(id, &request_block)
      @@requests[id] = request_block
    end

    def self.delete_request(id)
      # @@requests[id] = nil
    end
  end
end


module TonClient
  
  module TonBinding
    extend FFI::Library
    # ffi_lib FFI::Library::LIBC
    # ffi_lib 'ruby'
    
    # memory allocators
    # attach_function :malloc, [:size_t], :pointer
    # attach_function :calloc, [:size_t], :pointer
    # attach_function :valloc, [:size_t], :pointer
    # attach_function :realloc, [:pointer, :size_t], :pointer
    # attach_function :free, [:pointer], :void
    
    # # memory movers
    # attach_function :memcpy, [:pointer, :pointer, :size_t], :pointer
    # attach_function :bcopy, [:pointer, :pointer, :size_t], :void
    
    def self.setup_bindings

      # tc_string_handle_t* tc_create_context(tc_string_data_t config);
      # attach_function :tc_create_context, [TcStringDataT.by_value], TcStringHandleT.by_ref
      attach_function :tc_create_context, [TcStringDataT.by_value], :pointer

      # fn tc_destroy_context(context: InteropContext)
      attach_function :tc_destroy_context, [:uint32], :void

      # tc_string_handle_t* tc_request_sync(
      #   uint32_t context,
      #   tc_string_data_t function_name,
      #   tc_string_data_t function_params_json);
      # attach_function :tc_request_sync, [:uint32, TcStringDataT.by_value, TcStringDataT.by_value], TcStringHandleT.by_ref
      attach_function :tc_request_sync, [:uint32, TcStringDataT.by_value, TcStringDataT.by_value], :pointer

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
      attach_function :tc_request, [:uint32, TcStringDataT.by_value, TcStringDataT.by_value, :uint32, :tc_response_handler_t], :void

      # tc_string_data_t tc_read_string(const tc_string_handle_t* handle);
      # attach_function :tc_read_string, [TcStringHandleT.by_ref], TcStringDataT.by_value
      attach_function :tc_read_string, [:pointer], TcStringDataT.by_value

      # void tc_destroy_string(const tc_string_handle_t* handle)
      # attach_function :tc_destroy_string, [TcStringHandleT.by_ref], :void
      attach_function :tc_destroy_string, [:pointer], :void
    end

    def self.make_string(string)
      # p 1
      result = TonBinding::TcStringDataT.new
      # bytes_count = string.unpack("C*").size
      # ptr1 = FFI::MemoryPointer.new(:char, bytes_count)
      # ptr1.put_bytes(0, string, 0, bytes_count)
      # result[:content] = ptr1
      result[:content] = FFI::MemoryPointer.from_string(string)
      result[:len] = string.bytesize
      # result[:len] = ptr1.size
      # p 2
      result
    end

    def self.read_string(tc_string_handle)
      is_ref = tc_string_handle.class == FFI::Pointer
      if is_ref
        string = tc_read_string(tc_string_handle)
      else
        string = tc_string_handle
      end

      if string[:content].address > 1
        string = string[:content].read_string(string[:len])
        if is_ref
          tc_destroy_string(tc_string_handle)
          # free(tc_string_handle)
        end
        return string
      end
      nil
    end

    def self.read_string_to_hash(tc_string_handle_t_ref)
      json_string = read_string(tc_string_handle_t_ref)
      JSON.parse(json_string, {max_nesting: false}) if json_string
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

    # block = { |response| }
    def self.requestLibrary(context: 1, method_name: '', payload: {}, &block)
      raise 'context not found' unless context
      raise 'method_name is empty' if method_name.empty?

      request_id = generate_request_id
      method_name_string = make_string(method_name)
      payload_string = make_string(payload.to_json)
      set_request(request_id, &block)
      tc_request(context, method_name_string, payload_string, request_id) do |request_id, string_data, response_type, finished|
        request = get_request(request_id)
        if request
          response = Response.new
          response.update(request_id, string_data, response_type, finished)
          request.call(response)
          delete_request(request_id) if finished
        end
      end
    end

  end
end







