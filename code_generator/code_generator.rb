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
    generateModules(types)
    generateReadme(types)
  end

  private

  def generateModules(types)
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
    end
    
    p 'generate_self_code ok'
  end

  def generateReadme(types)
    readmePath = root_dir + "/README.md"
    content = %{
# Ruby Client for Free TON SDK

[![GEM](https://img.shields.io/badge/ruby-gem-green)]()

## Install

Install gem
```bash
gem install ton-client-ruby
```

Install TON-SDK
```bash
ton-client-ruby setup
```

### Manual build FreeTON SDK
0. Install Rust to your OS
1. git clone https://github.com/tonlabs/TON-SDK
2. cd ./TON-SDK
3. cargo update
4. cargo build --release

## Usage

```ruby
# For MAcOS
TonClient.configure { |config| config.ffi_lib(./TON-SDK/target/release/libton_client.dylib) }
# For Linux
# TonClient.configure { |config| config.ffi_lib(./TON-SDK/target/release/libton_client.so) }

client = TonClient.create(config: {network: {server_address: "net.ton.dev"}})

# All methods are asynchronous

# example: call method for Crypto module
payload = {composite: '17ED48941A08F981'}
client.crypto.factorize(payload) do |response|
  p response.result['factors']
end

# e.g. ...
```\n\n
}
    content << "## All Modules and methods\n\n"
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
spec_ffi=./TON-SDK/target/release/libton_client.dylib
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
}
    content.gsub!(/^([\s]+)# RESPONSE/, "\n\\1# RESPONSE")
    if File.exists?(readmePath)
        File.delete(readmePath)
    end
    File.open(readmePath, 'w+') { |f| f.write(content) }
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
    content << "#{TAB}#{TAB}attr_reader :core, :context\n"
    content << "#{TAB}#{TAB}private_accessor "
    modules.each_with_index do |m, i|
      next if m.name.downcase == 'client'
      content << ((modules.size - 1) == i ? ":_#{m.name}\n" : ":_#{m.name}, ")
    end
    content << "#{TAB}#{TAB}MODULE = self.to_s.downcase.gsub(/^(.+::|)(\\w+)$/, '\\2').freeze\n\n"
    content << "#{TAB}#{TAB}def initialize(context: Context.new, core: TonClient::TonBinding)\n"
    content << "#{TAB}#{TAB}#{TAB}@context = context\n"
    content << "#{TAB}#{TAB}#{TAB}@core = core\n#{TAB}#{TAB}end\n\n"
    content << "#{TAB}#{TAB}def destroy_context\n"
    content << "#{TAB}#{TAB}#{TAB}core.tc_destroy_context(context.id)\n#{TAB}#{TAB}end\n\n"
    modules.each_with_index do |m, i|
      next if m.name.downcase == 'client'
      content << "#{TAB}#{TAB}def #{m.name}\n"
      content << "#{TAB}#{TAB}#{TAB}_#{m.name} ||= #{m.name.capitalize}.new(context: context)\n"
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
    content << "#{TAB}#{TAB}attr_reader :core, :context\n"
    content << "#{TAB}#{TAB}MODULE = self.to_s.downcase.gsub(/^(.+::|)(\\w+)$/, '\\2').freeze\n\n"
    content << "#{TAB}#{TAB}def initialize(context: Context.new, core: TonClient::TonBinding)\n"
    content << "#{TAB}#{TAB}#{TAB}@context = context\n"
    content << "#{TAB}#{TAB}#{TAB}@core = core\n"
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
      content << "#{TAB}#{TAB}#{TAB}core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: {}, &block)\n"
    else
      content << "(payload, &block)\n"
      content << "#{TAB}#{TAB}#{TAB}core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)\n"
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
          content << "#{TAB}#{TAB}# #{arg.summary}" if arg.summary
          content << "#{TAB}#{TAB}# #{arg.description}" if arg.description
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
          content << "#{TAB}#{TAB}# #{arg.summary}" if arg.summary
          content << "#{TAB}#{TAB}# #{arg.description}" if arg.description
          content << "\n"
        end
      elsif types.all_types[function.result].respond_to?(:cases)
      end
    end

    content
  end
end











