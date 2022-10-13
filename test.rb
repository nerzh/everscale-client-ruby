require 'concurrent'
require 'thread'
require 'thwait'
require 'monitor'
require 'fiddle'
require 'fiddle/import'
require 'byebug'
require 'json'



module Test
  extend Fiddle::Importer
  extend Fiddle::CParser
  dlload('/Users/nerzh/.rvm/gems/ruby-2.7.5/gems/everscale-client-ruby-1.1.27/TON-SDK/target/release/libton_client.dylib')
  # dlopen('/Users/nerzh/.rvm/gems/ruby-2.7.5/gems/everscale-client-ruby-1.1.27/TON-SDK/target/release/libton_client.dylib')

  TcStringDataT = struct [
    'const char* content',
    'uint len'
  ]

  # tc_string_data_t tc_read_string(const tc_string_handle_t* handle);
  # extern 'void* tc_read_string(const void* handle)'
  extern 'TcStringDataT* tc_read_string(const TcStringDataT* handle)'
  # extern 'tc_string_data_t tc_read_string(const tc_string_handle_t* handle)'

  # tc_string_handle_t* tc_create_context(tc_string_data_t config);
  # extern 'void* tc_create_context(void* config)'
  extern 'TcStringDataT* tc_create_context(TcStringDataT* config)'

  def self.qqq
  @@qqq = Fiddle::Function.new(handler['tc_create_context'], [Fiddle::TYPE_CONST_STRING], Fiddle::TYPE_VOIDP)
  # @@qqq = Fiddle::Function.new(handler['tc_create_context'], [Fiddle::TYPE_VOIDP], Fiddle::TYPE_VOIDP)
  end

  def self.make_string(string)
    memory_address = string.object_id * 2
    ptr = Fiddle::Pointer.new(memory_address)
    byebug
  end

  def self.a
    p parse_struct_signature('TcStringDataT* tc_read_string(const tc_string_handle_t* handle)')
  end

end


def config
  {network: {endpoints: ["http://localhost:80"]}}.to_json
  p "{\"network\":{\"endpoints\":[\"http://localhost:80\"]}}".encode('utf-8') == {network: {endpoints: ["http://localhost:80"]}}.to_json
  {network: {endpoints: ["http://localhost:80"]}}.to_json
end

def struct
  config_ptr = Fiddle::Pointer.to_ptr(config)
  p "pointer len:", config_ptr
  # data = Test::TcStringDataT.malloc(Fiddle::RUBY_FREE)
  data = Test::TcStringDataT.malloc
  # data.content = config_ptr
  data.content = config_ptr.ptr
  # data.content = config_ptr.ptr.to_i
  data.len = config.bytesize
  # p "len: #{data.len}"
  # data
  data.to_ptr
  # config_ptr
end

def config_ptr
  Fiddle::Pointer.to_ptr(config)
end

def read(ptr)
  # ptr = Test.tc_read_string(ptr)
  data = Test::TcStringDataT.new(ptr)
  data.content
  data.content.to_s
end

# exit 0
# ptr = Test.qqq.call(data)
# ptr = Test.tc_create_context(config)
# ptr = Test.tc_create_context(ptr.ptr)
# ptr = Test.tc_create_context(data.to_i)
# data = Test::TcStringDataT.new(ptr)
# p data.content.to_s

#PASS STRUCT
ptr = Test.tc_create_context(struct)
# ptr = Test.tc_create_context(struct.to_ptr)
# ptr = Test.qqq.call(struct)
# ptr = Test.qqq.call(struct.to_ptr)

#PASS STRING PTR
# ptr = Test.tc_create_context(config_ptr)
# ptr = Test.tc_create_context(config_ptr.ptr)
# ptr = Test.qqq.call(config)
# ptr = Test.qqq.call(config_ptr.ptr)


# READ
p read(ptr)














