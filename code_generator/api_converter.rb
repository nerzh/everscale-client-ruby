require 'json'
require 'byebug'
require File.dirname(__FILE__) + '/helpers.rb'

class ApiConverter
  include InstanceHelpers

  attr_reader :api_hash
  
  def initialize(api_json)
    @api_hash = JSON.parse(api_json)
  end

  def convert_to_hash
  end

  private

  # def 

end

class ApiRubyTypes
  attr_accessor :version
  attr_accessor :modules
end

class Module
  attr_accessor :name
  attr_accessor :summary
  attr_accessor :description
  attr_accessor :alias
  attr_accessor :enums
  attr_accessor :types
  attr_accessor :functions
end

class TypeAlias
  attr_accessor :name
  attr_accessor :type
end

class TypeEnum
  attr_accessor :name
  attr_accessor :parents
  attr_accessor :cases  
end

class EnumCase
  attr_accessor :name
  attr_accessor :value
end

class TypeStruct
  attr_accessor :name
  attr_accessor :parents
  attr_accessor :fields
end

class StructField
  attr_accessor :name
  attr_accessor :type
end

class Function
  attr_accessor :name
  attr_accessor :arguments
  attr_accessor :result
end

class FunctionArgument
  attr_accessor :name
  attr_accessor :type
end
