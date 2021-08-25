#!/usr/bin/env ruby

script_file_path = File.expand_path(File.dirname(__FILE__))
version_file = "#{script_file_path}/../ton-client-ruby/version.rb"
file = File.read(version_file)

if file[/VERSION = "(\d+)\.(\d+)\.(\d+)"/]
  major = $1
  minor = $2
  current = $3
  version = "#{major}.#{minor}.#{current.to_i + 1}"
  data = "module TonClient\n  VERSION = \"#{version}\"\nend\n\n"
  File.open(version_file, 'wb') { |f| f.write(data) }
end

system(%{cd #{script_file_path}/../../ && rake release})
