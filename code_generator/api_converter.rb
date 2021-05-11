require 'json'
require 'byebug'
require File.dirname(__FILE__) + '/helpers.rb'



class ApiConverter
  include InstanceHelpers

  attr_reader :api_hash
  
  def initialize(api_json)
    @api_hash = JSON.parse(api_json)
  end

  def convert
    ruby_types = ApiRubyTypes.new(version: api_hash['version'], modules: [])

    (api_hash['modules'] || []).each do |mod|
      ruby_types.modules << convert_module(mod)
    end

    ruby_types
  end

  private

  def convert_module(mod)
    new_module = Module.new(name: mod['name'], alias: [], functions: [], enums: [], types: [], summary: mod['summary'], description: mod['description'])
    (mod['types'] || []).each do |type|
      if type['type'] == 'EnumOfTypes'
        convert_fucking_enum_of_types(type)
      elsif type['type'] == 'EnumOfConsts'
        convertEnumOfConsts(type)
      elsif type['type'] == 'Struct'
        convertStruct(type)
      elsif type['type'] == 'Number'
        convertTypeAlias(type)
      else
        raise "Unkown NEW TYPE for module #{type['name']} \"types\": #{type['types']}"
      end
    end

    # /// FUNCTIONS
    (mod['functions'] || []).each do |function|
        result = ""
        if function['result']['type'] == "Generic"
            ref_type = function['result']['generic_args'].first&.send(:[], 'type') || ""
            if ref_type == "Ref"
                ref_name = function['result']['generic_args'].first&.send(:[], 'ref_name') || ""
                if ref_name[/^(.+)\.(.+)$/]
                    mod = $1
                    type = $2
                    result = "#{lib_prefix}#{type}"
                else
                    raise "Bad function result ref_name: #{ref_name}, function name: #{function['name']}, result: #{function['result']}"
                end
            elsif ref_type == "None"
              result = "Void"
            end
        else
          raise "New function result type !"
        end

        # /// function
        newFunction = StructFunction.new(name: checkFunctionName(function['name']), arguments: [], result: result, summary: function['summary'], description: function['description'])
        # /// FUNCTION PARAMETERS
        paramsCount = 0
        (function['params'] || []).each do |parameter|
            if parameter['name'] == "params"
                paramsCount += 1
                if parameter['type'] == "Ref"
                    ref_name = parameter['ref_name'] || ""
                    if ref_name[/^(.+)\.(.+)$/]
                        mod = $1
                        type = $2
                        newFunction.arguments << FunctionArgument.new(name: "payload", type: "#{lib_prefix}#{type}")
                    else
                      raise "Bad function params ref_name: #{ref_name}, function name: #{function['name']}, result: #{function['result']}"
                    end
                else
                  raise "NEW CASE! New parameter type: #{parameter['type']}"
                end
            end
            raise "NEW CASE ! More then one parameter for functions !" if paramsCount > 1
        end

        new_module.functions << newFunction
    end

    new_module
  end

  def convertTypeAlias(from)
    TypeAlias.new(name: "#{lib_prefix}#{from['name']}", type: generateType(from))
  end

  def convertStruct(from)
    result = TypeStruct.new(name: "#{lib_prefix}#{from['name']}", parents: [], fields: [], functions: [])
    (from['struct_fields'] || []).each do |field|
      if isValidPropertyName(field['name'])
        type = generateType(field)
        if ( (from['name'] || "")[/Params/] || (field['name'] || "")[/input/]) && type[/Value/]
          type = "Value"
        elsif (field['name'] || "")[/^dictionary$/]
          type = "TSDKMnemonicDictionary"
        end
        property = StructField.new(name: checkPropertyName(field['name']), type: type, summary: field['summary'], description: field['description'])
        result.fields << property
      end
    end

    result
  end

  private def checkPropertyName(name)
      result = ""
      raise "Property Name is nil" unless name
      
      case name
      when "public"
          result = "public"
      else
          result = name
      end

      return result
  end

  private def checkFunctionName(name)
    result = ""
    raise "Property Name is nil" unless name
    case name
    when "init"
      result = "init"
    else
      result = name
    end

    return result
  end

  private def isValidPropertyName(name)
    !(name || " ")[/\s/]
  end

  def convertEnumOfConsts(from)
      result = TypeEnum.new(name: "#{lib_prefix}#{from['name']}", parents: [], cases: [], summary: from['summary'], description: from['description'])
      (from['enum_consts'] || []).each do |enumConst|
          caseName = enumConst['name']
          caseValue = enumConst['type']
          result.cases << EnumCase.new(name: caseName, value: caseValue, summary: enumConst['summary'], description: enumConst['description'])
      end

      return result
  end

  def convert_fucking_enum_of_types(enum)
    result = [
      TypeEnum.new(name: generate_enum_name(enum['name']), parents: [], cases: []),
      TypeStruct.new(name: generate_struct_name(enum['name']), parents: [], fields: [], functions: [], summary: enum['summary'], description: enum['description'])
    ]
    properties_name_set = Set.new
    properties = []
    (enum['enum_types'] || []).each do |enum_type|
      result[0].cases << EnumCase.new(name: enum_type['name'], value: enum_type['name'])
      (enum_type['struct_fields'] || []).each do |field|
        if !properties_name_set.include?(field['name'])
          properties << field
        end
        properties_name_set << field['name']
      end
    end

    result[1].fields << StructField.new(name: "type", type: generate_enum_name(enum['name']))
    properties.each do |property|
      type = generateType(property)
      if property['name'][/^dictionary$/]
        type = "TSDKMnemonicDictionary"
      end
      result[1].fields << TypeStruct.new(name: property['name'], type: type, summary: property['summary'], description: property['description'])
    end
    result
  end

  private def generateSimpleType(type)
    tempType = ""

    if type['type'] == "Ref"
      if type['ref_name'] == "Value" || type['ref_name'] == "API"
        tempType = "Value"
      else
        return generateRefType(type['ref_name'] || "nil")
      end
    else
      tempType = type['type']
    end

    tempType
  end

  private def generateRefType(type)
    result = ""

    if type[/(.+)\.(.+)/]
      mod = $1
      typeName = $2
      result = "#{lib_prefix}#{typeName}"
    else
      result = "#{lib_prefix}#{type}"
    end

    result
  end

  private def generateType(type)
    if type['type'] == "Optional" && type['optional_inner']
      if type['optional_inner']['type'] == "Optional"
        return generateType(type['optional_inner'])
      else
        return generateSimpleType(type['optional_inner'])
      end
    else 
      return generateSimpleType(type)
    end
  end

  private def generate_enum_name(name)
    "#{lib_prefix}#{name}#{lib_enum_postfix}"
  end

  private def generate_struct_name(name)
    "#{lib_prefix}#{name}"
  end
end


class ApiRubyTypes
  attr_accessor :version
  attr_accessor :modules

  def initialize(params)
    params.each do |k, v|
      if self.respond_to?(k.to_sym)
        instance_variable_set("@#{k}".to_sym, v)
      end
    end
  end
end

class Module
  attr_accessor :name
  attr_accessor :summary
  attr_accessor :description
  attr_accessor :alias
  attr_accessor :enums
  attr_accessor :types
  attr_accessor :functions
  attr_accessor :summary
  attr_accessor :description

  def initialize(params)
    params.each do |k, v|
      if self.respond_to?(k.to_sym)
        instance_variable_set("@#{k}".to_sym, v)
      end
    end
  end
end

class TypeAlias
  attr_accessor :name
  attr_accessor :type
  attr_accessor :summary
  attr_accessor :description

  def initialize(params)
    params.each do |k, v|
      if self.respond_to?(k.to_sym)
        instance_variable_set("@#{k}".to_sym, v)
      end
    end
  end
end

class TypeEnum
  attr_accessor :name
  attr_accessor :parents
  attr_accessor :cases
  attr_accessor :summary
  attr_accessor :description

  def initialize(params)
    params.each do |k, v|
      if self.respond_to?(k.to_sym)
        instance_variable_set("@#{k}".to_sym, v)
      end
    end
  end
end

class EnumCase
  attr_accessor :name
  attr_accessor :value
  attr_accessor :summary
  attr_accessor :description

  def initialize(params)
    params.each do |k, v|
      if self.respond_to?(k)
        instance_variable_set("@#{k}".to_sym, v)
      end
    end
  end
end

class TypeStruct
  attr_accessor :name
  attr_accessor :parents
  attr_accessor :fields
  attr_accessor :functions
  attr_accessor :summary
  attr_accessor :description

  def initialize(params)
    params.each do |k, v|
      if self.respond_to?(k.to_sym)
        instance_variable_set("@#{k}".to_sym, v)
      end
    end
  end
end

class StructField
  attr_accessor :name
  attr_accessor :type
  attr_accessor :summary
  attr_accessor :description

  def initialize(params)
    params.each do |k, v|
      if self.respond_to?(k.to_sym)
        instance_variable_set("@#{k}".to_sym, v)
      end
    end
  end
end

class StructFunction
  attr_accessor :name
  attr_accessor :arguments
  attr_accessor :result
  attr_accessor :summary
  attr_accessor :description

  def initialize(params)
    params.each do |k, v|
      if self.respond_to?(k.to_sym)
        instance_variable_set("@#{k}".to_sym, v)
      end
    end
  end
end

class FunctionArgument
  attr_accessor :name
  attr_accessor :type

  def initialize(params)
    params.each do |k, v|
      if self.respond_to?(k.to_sym)
        instance_variable_set("@#{k}".to_sym, v)
      end
    end
  end
end
