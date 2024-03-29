module TonClient
  module TonBinding
    class Response
      attr_accessor :result, :error, :custom_response, :finished, :request_id, :response_type

      def initialize(request_id, string_data, response_type, finished)
        update(request_id, string_data, response_type, finished)
      end

      private
      def update(request_id, string_data, response_type, finished)
        if response_type == -1
          @finished = true
          @request_id = request_id
          @response_type = response_type
          @error = string_data || "Client deallocated"
          p "ERROR:   #{@error}"
          return self
        end

        response_hash = TonBinding.read_string_to_hash(TonBinding.read_string_data(string_data))
        @finished = finished
        @request_id = request_id
        @response_type = response_type
        
        case response_type
        when 0
          # result
          @result = response_hash
        when 1
          # error
          @error = response_hash
        else
          # # another
          # if response_type >= 100
          @custom_response = response_hash
          # end
        end

        self
      end
    end
  end
end


module TonClient
  
  module TonBinding
    extend FFI::Library
    ffi_lib FFI::Library::LIBC
    ffi_lib 'ruby'
    
    # memory allocators
    attach_function :malloc, [:size_t], :pointer
    # attach_function :calloc, [:size_t], :pointer
    # attach_function :valloc, [:size_t], :pointer
    # attach_function :realloc, [:pointer, :size_t], :pointer
    attach_function :free, [:pointer], :void
    
    # # memory movers
    # attach_function :memcpy, [:pointer, :pointer, :size_t], :pointer
    # attach_function :bcopy, [:pointer, :pointer, :size_t], :void
    
    def self.setup_bindings

      # tc_string_handle_t* tc_create_context(tc_string_data_t config);
      # attach_function :tc_create_context, [TcStringDataT.by_value], TcStringDataT.by_ref
      attach_function :tc_create_context, [TcStringDataT.by_value], :pointer

      # fn tc_destroy_context(context: InteropContext)
      attach_function :tc_destroy_context, [:uint32], :void

      # tc_string_handle_t* tc_request_sync(
      #   uint32_t context,
      #   tc_string_data_t function_name,
      #   tc_string_data_t function_params_json);
      # attach_function :tc_request_sync, [:uint32, TcStringDataT.by_value, TcStringDataT.by_value], TcStringDataT.by_ref
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
      # attach_function :tc_read_string, [TcStringDataT.by_ref], TcStringDataT.by_value
      attach_function :tc_read_string, [:pointer], TcStringDataT.by_value

      # void tc_destroy_string(const tc_string_handle_t* handle)
      # attach_function :tc_destroy_string, [TcStringDataT.by_ref], :void
      attach_function :tc_destroy_string, [:pointer], :void
    end

    def self.make_string(string)
      string = string.encode("utf-8").freeze
      result = TonBinding::TcStringDataT.new
      result[:content] = FFI::MemoryPointer.from_string(string)
      result[:len] = string.bytesize
      result
    end

    def self.read_string_data_ref(tc_string_handle_ref)
      string = tc_read_string(tc_string_handle_ref)

      if string[:len] > 0
        result = string[:content].read_string(string[:len]).freeze
        if tc_string_handle_ref
          tc_destroy_string(tc_string_handle_ref)
        else
          p "NOOOOOOOOOOOO"
        end
        # free(tc_string_handle_ref)
        result
      else
        nil
      end
    end

    def self.read_string_data(tc_string_data)
      if tc_string_data[:len] > 0
        result = tc_string_data[:content].read_string(tc_string_data[:len]).freeze
        # free(tc_string_data)
        result
      else
        nil
      end
    end

    def self.read_string_to_hash(json_string)
      JSON.parse(json_string, {max_nesting: false}) if json_string
    end

    def self.send_request_sync(context: 1, method_name: '', payload: {})
      raise 'context not found' unless context
      raise 'method_name is empty' if method_name.empty?

      method_name_string = make_string(method_name)
      payload_string = make_string(payload.to_json)

      sdk_json_response = tc_request_sync(context, method_name_string, payload_string)
      response = read_string_to_hash(read_string_data_ref(sdk_json_response))

      response
    end

    # block = { |response| }
    def self.requestLibrary(context: nil,
                            request_id: nil,
                            requests: nil,
                            monitor: nil,
                            method_name: '',
                            payload: {},
                            &block
    )
      monitor&.synchronize do
        raise 'context not found' unless context
        raise 'method_name is empty' if method_name.empty?
        # raise "context: #{context}. request_id not is nil. Client dealloc." unless request_id
        unless request_id
          # p "context: #{context}. request_id is nil. Client deallocated."
          block.call(Response.new(request_id, "Client deallocated", -1, true)) if block
          return
        end
        method_name_string = make_string(method_name)
        payload_string = make_string(payload.to_json)

        request_id = request_id.increment
        requests[request_id] = block
        # p "start id #{request_id} - requests #{requests.object_id}"
        tc_request(context, method_name_string, payload_string, request_id) do |request_id, string_data, response_type, finished|
          # p "rust inside id #{request_id} - #{method_name}"
          begin
            monitor&.synchronize do
              # p "request_id #{request_id}, monitor #{monitor.object_id} - requests #{requests.object_id}"
              request = requests[request_id]
              if request
                request.call(Response.new(request_id, string_data, response_type, finished))
                requests.delete(request_id) if finished
              end
            end
          rescue => ex
            block.call(Response.new(request_id, ex.message, -1, true)) if block
          end
        end
      end
    rescue => ex
      block.call(Response.new(request_id, ex.message, -1, true)) if block
    end

  end
end







