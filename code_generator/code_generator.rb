require 'byebug'
require 'json'
require File.dirname(__FILE__) + '/helpers.rb'

class CodeGenerator

  attr_accessor :types
  attr_accessor :root_dir

  TAB = "  "

  def initialize(types, root_dir)
    @types = types
    @root_dir = root_dir
  end

  def generate_self_code
    types.modules.each do |mod|
      modulesFolder = root_dir + "/lib/ton-client-ruby/Client"
      moduleFilePath = "#{modulesFolder}/#{mod.name.capitalize}.rb"
      newModuleContent = ""
      if mod.name == "client"
          newModuleContent = generateClientModule(mod, types.modules)
      else
          newModuleContent = generateModule(mod)
      end
      if File.exists?(moduleFilePath)
          File.delete(moduleFilePath)
      end
      File.open(moduleFilePath, 'w+') { |f| f.write(newModuleContent) }

      # var newTypes: String = ""

      # for newAlias in module.alias {
      #     newTypes.append(generateAlias(newAlias))
      # }

      # for newEnum in module.enums {
      #     newTypes.append(generateEnum(newEnum))
      # }

      # for newStruct in module.types {
      #     newTypes.append(generateStruct(newStruct))
      # }

      # let moduleTypesFilePath: String = "\(moduleClassFolder)/\(module.name.capitalized)Types.swift"
      # FileUtils.writeFile(to: moduleTypesFilePath, newTypes)
    end
    
    p 'generate_self_code ok'
  end

  private def generateClientModule(mod, modules)
    content = "module TonClient\n\n#{TAB}class #{mod.name.capitalize}\n#{TAB}#{TAB}include CommonInstanceHelpers\n\n"
    content << "#{TAB}#{TAB}attr_reader :core, :context\n"
    content << "#{TAB}#{TAB}private_accessor "
    modules.each_with_index do |m, i|
      next if m.name.downcase == 'client'
      content << ((modules.size - 1) == i ? ":_#{m.name}\n" : ":_#{m.name}, ")
    end
    content << "#{TAB}#{TAB}MODULE = self.to_s.downcase.gsub(/^(.+::|)(\\w+)$/, '\\2').freeze\n\n"
    content << "#{TAB}#{TAB}def initialize(context: Context.new, core: TonClient::TonBinding)\n"
    content << "#{TAB}#{TAB}#{TAB}@context = context\n"
    content << "#{TAB}#{TAB}#{TAB}@core = core\nend\n\n"
    content << "#{TAB}#{TAB}def destroy_context\n"
    content << "#{TAB}#{TAB}#{TAB}core.tc_destroy_context(context.id)\nend\n\n"
    modules.each_with_index do |m, i|
      next if m.name.downcase == 'client'
      content << "#{TAB}#{TAB}def #{m.name}\n"
      content << "#{TAB}#{TAB}#{TAB}_#{m.name} ||= #{m.name.capitalize}.new(context: context)\n"
      content << "#{TAB}#{TAB}end\n\n"
    end

    mod.functions.each do |func|
      content << gen_function(func)
    end

    content << "#{TAB}end\n"
    content << "end\n\n"

    content
  end

  private def generateModule(mod)
    content = "module TonClient\n\n#{TAB}class #{mod.name.capitalize}\n#{TAB}#{TAB}include CommonInstanceHelpers\n\n"
    content << "#{TAB}#{TAB}attr_reader :core, :context\n"
    content << "#{TAB}#{TAB}MODULE = self.to_s.downcase.gsub(/^(.+::|)(\\w+)$/, '\\2').freeze\n\n"
    content << "#{TAB}#{TAB}def initialize(context: Context.new, core: TonClient::TonBinding)\n"
    content << "#{TAB}#{TAB}#{TAB}@context = context\n"
    content << "#{TAB}#{TAB}#{TAB}@core = core\n"
    content << "#{TAB}#{TAB}end\n\n"

    mod.functions.each do |func|
      content << gen_function(func)
    end

    content << "#{TAB}end\n"
    content << "end\n\n"

    content
  end

  private def gen_function(function)
    content = "#{TAB}#{TAB}def #{function.name}"
    if function.arguments.empty?
      content << "(&block)\n"
      content << "#{TAB}#{TAB}#{TAB}core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: {}, &block)\n"
    else
      content << "(payload, &block)\n"
      content << "#{TAB}#{TAB}#{TAB}core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)\n"
    end
    content << "#{TAB}#{TAB}end\n\n"

    content
  end
end











