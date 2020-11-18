
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ton-client-ruby/version"

Gem::Specification.new do |spec|
  spec.name          = "ton-client-ruby"
  spec.version       = TonClient::VERSION
  spec.authors       = ["nerzh"]
  spec.email         = ["emptystamp@gmail.com"]

  spec.summary       = 'This is gem ton-client-ruby'
  spec.description   = 'Gem Ton Client Ruby for all ruby projects'
  spec.homepage      = 'https://github.com/nerzh/ton-client-ruby'
  spec.license       = 'MIT'

  spec.files         = Dir['lib/**/*']
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  
  spec.add_runtime_dependency 'ffi', '~> 1.13.1'
  spec.add_runtime_dependency 'dotenv', '~> 2.7.6'

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "rspec"
end
