# Ruby Client for Free TON SDK

[![GEM](https://img.shields.io/badge/ruby-gem-green)]()

## Build FreeTON SDK
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
```

___I will write a list of existing methods later. But now you can see what modules there are, what methods they have and how to use them in tests for this library, since each method is covered by tests.___

## Tests

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
