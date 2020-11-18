# Ruby Client for Free TON SDK


## Build FreeTON SDK
0. Install Rust to your OS
1. git clone https://github.com/tonlabs/TON-SDK
2. cd ./TON-SDK
3. cargo update
4. cargo build --release

## Usage

```ruby
TonClient.configure { |config| config.ffi_lib(./TON-SDK/target/release/libton_client.dylib) }
client = TonClient.create(config: {network: {server_address: "net.ton.dev"}})

# All methods are asynchronous

# example: call method for Crypto module
payload = {composite: '17ED48941A08F981'}
client.crypto.factorize(payload) do |response|
  p response.result['factors']
end
```

## Tests

1. create .env.test file inside root directory of this library with variables   

example for NodeSE   
```
spec_ffi=path_to_TON-SDK/target/debug/libton_client.dylib
server_address=http://localhost:80
giver_address=0:841288ed3b55d9cdafa806807f02a0ae0c169aa5edfe88a789a6482429756a94
giver_abi_name=GiverNodeSE
giver_function=sendGrams
giver_amount=10000000000
```
2. Run tests  
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
