#!/usr/bin/env ruby

script_file_path = File.expand_path(File.dirname(__FILE__))

require "#{script_file_path}/lib/code_generator/api_converter.rb"
require "#{script_file_path}/lib/code_generator/code_generator.rb"

GEM_DIR = "#{script_file_path}"


`cd #{script_file_path} && curl https://raw.githubusercontent.com/tonlabs/TON-SDK/master/tools/api.json > api.json`
api_json_path = "#{script_file_path}/api.json"
json = ''
if File.exists?(api_json_path)
  json = File.read(api_json_path)
else
  p "File #{api_json_path} is not exist"
  exit 0
end
converter = ApiConverter.new(json)
types = converter.convert
generator = CodeGenerator.new(types, GEM_DIR)
generator.generate_self_code

version_file = "#{script_file_path}/lib/ton-client-ruby/version.rb"
file = File.read(version_file)

p 'check version'
if file[/VERSION = "(\d+)\.(\d+)\.(\d+)"/]
  major = $1
  minor = $2
  current = $3
  version = "#{major}.#{minor}.#{current.to_i + 1}"
  p version
  data = "module TonClient\n  VERSION = \"#{version}\"\nend\n\n"
  p data
  p version_file
  File.open(version_file, 'wb') { |f| f.write(data) }
  p 'update version'
end

puts "make release? Y/N"
option = gets
if option.strip.downcase == 'y'
  system(%{cd #{script_file_path}/../../ && rake release})
end

