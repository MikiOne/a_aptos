
### 编译与测试
```shell
# 水龙头领取
aptos account fund-with-faucet --account default
aptos move compile --named-addresses hello_aptos_chain=default
aptos move test --named-addresses hello_aptos_chain=default

```

```shell
aptos move test --named-addresses hello_aptos_chain=default
INCLUDING DEPENDENCY AptosFramework
INCLUDING DEPENDENCY AptosStdlib
INCLUDING DEPENDENCY MoveStdlib
BUILDING hello_aptos_chain
Running Move unit tests
[debug] "Running test for sender_can_set_message..."
[ PASS    ] 0x3f4638379e881e2c4803f3ee73d83b0f157f60fcb6f39ac90eab69817ce09f16::message_tests::sender_can_set_message
[ PASS    ] 0x3f4638379e881e2c4803f3ee73d83b0f157f60fcb6f39ac90eab69817ce09f16::message::sender_can_set_message
Test result: OK. Total tests: 2; passed: 2; failed: 0
{
  "Result": "Success"
}


aptos account fund-with-faucet --account default
{
  "Result": "Added 100000000 Octas to account 0x3f4638379e881e2c4803f3ee73d83b0f157f60fcb6f39ac90eab69817ce09f16"
}

```

### 发布模块
```shell
aptos move publish --named-addresses hello_aptos_chain=default
Compiling, may take a little while to download git dependencies...
UPDATING GIT DEPENDENCY https://github.com/aptos-labs/aptos-core.git
INCLUDING DEPENDENCY AptosFramework
INCLUDING DEPENDENCY AptosStdlib
INCLUDING DEPENDENCY MoveStdlib
BUILDING hello_aptos_chain
package size 1742 bytes
Do you want to submit a transaction for a range of [160300 - 240400] Octas at a gas unit price of 100 Octas? [yes/no] >
yes
Transaction submitted: https://explorer.aptoslabs.com/txn/0xa7789b36cfaae776ad345894a2ace5928bb7fe4cdeb96ffe08240bf06b3d88be?network=devnet
{
  "Result": {
    "transaction_hash": "0xa7789b36cfaae776ad345894a2ace5928bb7fe4cdeb96ffe08240bf06b3d88be",
    "gas_used": 1603,
    "gas_unit_price": 100,
    "sender": "3f4638379e881e2c4803f3ee73d83b0f157f60fcb6f39ac90eab69817ce09f16",
    "sequence_number": 0,
    "success": true,
    "timestamp_us": 1727598966370679,
    "version": 32486450,
    "vm_status": "Executed successfully"
  }
}

```

### **通过终端交互命令行调用`set_message` 方法**

调用 set_message 方法：

```bash
aptos move run --function-id 'default::message::set_message' --args string:"Hello, Aptos"
aptos move run --function-id 'default::message::set_message' --args string:"Hello, Aptos Chain"

Do you want to submit a transaction for a range of [44400 - 66600] Octas at a gas unit price of 100 Octas? [yes/no] >
yes
Transaction submitted: https://explorer.aptoslabs.com/txn/0x0ba6d7bd24c2090bf940ec5852afa99bba0696164ff793c595bff7a5eb1b6668?network=devnet
{
  "Result": {
    "transaction_hash": "0x0ba6d7bd24c2090bf940ec5852afa99bba0696164ff793c595bff7a5eb1b6668",
    "gas_used": 444,
    "gas_unit_price": 100,
    "sender": "3f4638379e881e2c4803f3ee73d83b0f157f60fcb6f39ac90eab69817ce09f16",
    "sequence_number": 1,
    "success": true,
    "timestamp_us": 1727600398171578,
    "version": 32663466,
    "vm_status": "Executed successfully"
  }
}
```

调用get_message方法

```bash
aptos move view --function-id 'default::message::get_message' --args address:default

{
  "Result": [
    "Hello, Aptos"
  ]
}

```