require 'json'
require File.dirname(__FILE__) + '/helpers.rb'

class CodeGenerator
  include InstanceHelpers

  attr_accessor :types
  attr_accessor :root_dir

  TAB = "  "

  def initialize(types, root_dir)
    @types = types
    @root_dir = root_dir
  end

  def generate_self_code
    generateModules(types)
    generateReadme(types)
  end

  private

  def generateModules(types)
    types.modules.each do |mod|
      modulesFolder = root_dir + "/lib/everscale-client-ruby/Client"
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
    end
    
    p 'generate_self_code ok'
  end

  def generateReadme(types)
    readmePath = root_dir + "/README.md"
    content = %{
# Ruby Client for Free TON SDK

[![GEM](https://img.shields.io/badge/ruby-gem-orange)](https://rubygems.org/gems/everscale-client-ruby)
[![SPM](https://img.shields.io/badge/SDK%20VERSION-#{types.version}-green)](https://github.com/tonlabs/TON-SDK)

## Install

Install gem
```bash
gem install everscale-client-ruby
```

Install TON-SDK
```bash
everscale-client-ruby setup
# result - path to dylib file for everscale-client-ruby configuration
```

### Manual build FreeTON SDK
0. Install Rust to your OS
1. git clone https://github.com/tonlabs/ever-sdk
2. cd ./ever-sdk
3. cargo update
4. cargo build --release

## Usage

```ruby
# For MAcOS
TonClient.configure { |config| config.ffi_lib(./ever-sdk/target/release/libton_client.dylib) }
# For Linux
# TonClient.configure { |config| config.ffi_lib(./ever-sdk/target/release/libton_client.so) }

client = TonClient.create(config: {network: {endpoints: ["https://eri01.net.everos.dev", "https://rbx01.net.everos.dev"]}})

# All methods are asynchronous

# example: call method for Crypto module
payload = {composite: '17ED48941A08F981'}
client.crypto.factorize(payload) do |response|
  p response.result['factors']
end

# e.g. ...
```\n\n
}
    content << "## All Modules, methods and types\n\n"

    # types
    content << "<details>\n#{TAB}<summary>Types</summary>\n\n"
    
    content << "#{customTypes()}\n"

    types.modules.each do |mod|
      (mod.enums || []).each do |type|
        content << checkComment(type.summary, 0) if type.summary
        content << checkComment(type.description, 0) if type.description
        content << "\n- #### #{type.name}\n"
        (type.cases || []).each do |enum_case|
          content << "#{checkComment(enum_case.summary, 1).gsub(/#/, '')}" if enum_case.summary
          content << "#{checkComment(enum_case.description, 1).gsub(/#/, '')}" if enum_case.description
          content << "#{TAB}- case #{enum_case.name} = #{enum_case.value}\n\n"
        end
      end

      (mod.types || []).each do |type|
        content << checkComment(type.summary, 0) if type.summary
        content << checkComment(type.description, 0) if type.description
        content << "\n- #### #{type.name}\n"
        (type.fields || []).each do |field|
          content << "#{checkComment(field.summary, 1).gsub(/#/, '')}\n" if field.summary
          content << "#{checkComment(field.description, 1).gsub(/#/, '')}\n" if field.description
          content << "#{TAB}- #{field.name}: #{field.type}\n\n"
        end
      end
    end
    content << "</details>\n\n"

    # methods
    types.modules.each do |mod|
      content << "<details>\n#{TAB}<summary>#{mod.name&.upcase}</summary>\n\n"
      (mod.functions || []).each do |function|
        content << "```ruby\n"
        content << checkComment(function.summary, 2) if function.summary
        content << checkComment(function.description, 2) if function.description
        content << "\n#{TAB}#{TAB}def #{function.name}"
        if function.arguments.empty?
          content << "(&block)\n"
        else
          content << "(payload, &block)\n"
        end
        content << getFunctionComment(function, types)
        content << "```\n"
      end
      content << "</details>\n\n"
    end

    content << %{
\n## Tests

1. create __.env.test__ file inside root directory of this library with variables   

example for NodeSE   
```
spec_ffi=./ever-sdk/target/release/libton_client.dylib
server_address=http://localhost:80
giver_abi_name=GiverNodeSE
giver_amount=10000000000
```
2. Run tests: inside folder of this library execute this commands      
**rspec spec/binding.rb**   
**rspec spec/client.rb**  
**rspec spec/context.rb**  
**rspec spec/abi.rb**   
**rspec spec/boc.rb**   
**rspec spec/crypto.rb**   
**rspec spec/net.rb**   
**rspec spec/processing.rb**   
**rspec spec/tvm.rb**   
**rspec spec/utils.rb**

\n## Update\n\n
```\n
everscale-client-ruby update\n 
```\n\n
or\n\n 
```\n
curl https://raw.githubusercontent.com/tonlabs/ever-sdk/master/tools/api.json > api.json\n\n
```\n\n
```\n
everscale-client-ruby update ./api.json\n
```\n
or\n\n 
```\n
cd everscale-client-ruby\n
```\n\n
```\n
./bin/everscale-client-ruby update\n
```\n 
}
    content = checkContent(content)    
    if File.exists?(readmePath)
        File.delete(readmePath)
    end
    File.open(readmePath, 'w+') { |f| f.write(content) }
  end

  private def checkContent(content)
    content.gsub!(/^([\s]+)# RESPONSE/, "\n\\1# RESPONSE")
    content.gsub(/<Optional>/i, '&lt;Optional&gt;')
    content.gsub(/(```ruby[\s\S]+?)&lt;Optional&gt;([\s\S]+?)```/, '\1<Optional>\2```')
    content.gsub!(/ +# +# +/, " ")
    # content.gsub!(/ +# +/, '. ')
  end

  def customTypes
    content = %{
- #### #{lib_prefix}MnemonicDictionary
#{TAB}- case TON = 0
#{TAB}- case ENGLISH = 1
#{TAB}- case CHINESE_SIMPLIFIED = 2
#{TAB}- case CHINESE_TRADITIONAL = 3
#{TAB}- case FRENCH = 4
#{TAB}- case ITALIAN = 5
#{TAB}- case JAPANESE = 6
#{TAB}- case KOREAN = 7
#{TAB}- case SPANISH = 8
}
  content
  end

  private def checkComment(string, tabs = 1)
      replacedString = "\n"
      tab = ""
      tabs.times do |i|
          tab << TAB
      end
      comment = "#"
      replacedString << "#{tab}#{comment} "
      symbolsWithSpace = "\\.|\\:|\\!|\\?|\\;"
      regxp = /([^#{symbolsWithSpace}])\n/
      result = string
      result.gsub!(/\n+/, "\n")
      result.gsub!(/ \n/, "\n#{comment} ")
      result.gsub!(/(#{symbolsWithSpace})\s*\n/, "\\1#{replacedString}")
      result.gsub!(regxp, "\\1")
      "#{tab}# #{result}"
  end

  private def generateClientModule(mod, modules)
    content = "module TonClient\n\n#{TAB}class #{mod.name.capitalize}\n#{TAB}#{TAB}include CommonInstanceHelpers\n\n"
    content << "#{TAB}#{TAB}attr_reader :context, :context_config, :request_id, :requests\n"
    content << "#{TAB}#{TAB}private_accessor "
    modules.each_with_index do |m, i|
      next if m.name.downcase == 'client'
      content << ((modules.size - 1) == i ? ":_#{m.name}\n" : ":_#{m.name}, ")
    end
    content << "#{TAB}#{TAB}MODULE = self.to_s.downcase.gsub(/^(.+::|)(\\w+)$/, '\\2').freeze\n\n"
    content << "#{TAB}#{TAB}def initialize(context_config: {})\n"
    content << "#{TAB}#{TAB}#{TAB}@context_config = context_config\n"
    content << "#{TAB}#{TAB}#{TAB}@request_id = Concurrent::AtomicFixnum.new(1)\n"
    content << "#{TAB}#{TAB}#{TAB}@requests = Concurrent::Hash.new()\n"
    content << "#{TAB}#{TAB}#{TAB}config = TonBinding.make_string(context_config.to_json)\n"
    content << "#{TAB}#{TAB}#{TAB}context_ptr = TonBinding.tc_create_context(config)\n"
    content << "#{TAB}#{TAB}#{TAB}@context = TonBinding.read_string_to_hash(context_ptr)['result']\n"
    content << "#{TAB}#{TAB}#{TAB}ObjectSpace.define_finalizer(self, self.class.finalize(@context))\n"
    content << "#{TAB}#{TAB}end\n\n"
    content << "#{TAB}#{TAB}def self.finalize(ctx)\n"
    content << "#{TAB}#{TAB}#{TAB}Proc.new do\n"
    content << "#{TAB}#{TAB}#{TAB}#{TAB}if (ctx != nil) && (ctx > 0)\n"
    content << "#{TAB}#{TAB}#{TAB}#{TAB}#{TAB}TonBinding.tc_destroy_context(ctx)\n"
    content << "#{TAB}#{TAB}#{TAB}#{TAB}end\n"
    content << "#{TAB}#{TAB}#{TAB}end\n"
    content << "#{TAB}#{TAB}end\n\n"
    modules.each_with_index do |m, i|
      next if m.name.downcase == 'client'
      content << "#{TAB}#{TAB}def #{m.name}\n"
      content << "#{TAB}#{TAB}#{TAB}_#{m.name} ||= #{m.name.capitalize}.new(context: context, request_id: request_id, requests: requests)\n"
      content << "#{TAB}#{TAB}end\n\n"
    end

    mod.functions.each do |func|
      content << gen_function(func, types)
    end

    content << "#{TAB}end\n"
    content << "end\n\n"

    content
  end

  private def generateModule(mod)
    content = "module TonClient\n\n#{TAB}class #{mod.name.capitalize}\n#{TAB}#{TAB}include CommonInstanceHelpers\n\n"
    content << "#{TAB}#{TAB}attr_reader :context, :request_id, :requests\n"
    content << "#{TAB}#{TAB}MODULE = self.to_s.downcase.gsub(/^(.+::|)(\\w+)$/, '\\2').freeze\n\n"
    content << "#{TAB}#{TAB}def initialize(context: nil, request_id: nil, requests: nil)\n"
    content << "#{TAB}#{TAB}#{TAB}@context = context\n"
    content << "#{TAB}#{TAB}#{TAB}@request_id = request_id\n"
    content << "#{TAB}#{TAB}#{TAB}@requests = requests\n"
    content << "#{TAB}#{TAB}end\n\n"

    mod.functions.each do |func|
      content << gen_function(func, types)
    end

    content << "#{TAB}end\n"
    content << "end\n\n"

    content
  end

  private def gen_function(function, types)
    content = getFunctionComment(function, types)
    content << "#{TAB}#{TAB}def #{function.name}"
    if function.arguments.empty?
      content << "(&block)\n"
      content << "#{TAB}#{TAB}#{TAB}TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, method_name: full_method_name(MODULE, __method__.to_s), payload: {}, &block)\n"
    else
      content << "(payload, &block)\n"
      content << "#{TAB}#{TAB}#{TAB}TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)\n"
    end
    content << "#{TAB}#{TAB}end\n\n"

    content
  end

  def getFunctionComment(function, types)
    content = ''
    if argument = function.arguments.first
      content << "#{TAB}#{TAB}# INPUT: #{argument.type}\n"
      if types.all_types[argument.type].respond_to?(:fields)
        types.all_types[argument.type].fields.each do |arg|
          content << "#{TAB}#{TAB}# #{arg.name}: #{arg.type} - "
          content << "#{TAB}#{TAB}# #{checkComment(arg.summary, 2)}" if arg.summary
          content << "#{TAB}#{TAB}# #{checkComment(arg.description, 2)}" if arg.description
          content << "\n"
        end
      elsif types.all_types[argument.type].respond_to?(:cases)
      end
    end
    
    if types.all_types[function.result]
      content << "#{TAB}#{TAB}# RESPONSE: #{function.result}\n"
      if types.all_types[function.result].respond_to?(:fields)
        types.all_types[function.result].fields.each do |arg|
          content << "#{TAB}#{TAB}# #{arg.name}: #{arg.type} - "
          content << "#{TAB}#{TAB}# #{checkComment(arg.summary, 2)}" if arg.summary
          content << "#{TAB}#{TAB}# #{checkComment(arg.description, 2)}" if arg.description
          content << "\n"
        end
      elsif types.all_types[function.result].respond_to?(:cases)
      end
    end

    content
  end
end











