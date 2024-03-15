# CALL vs STATICCALL vs DELEGATECALL

### 三种调用外部合约的方式

#### call方法:
- 用于调用其他合约的函数或向其他地址(合约地址/外部账户地址)发送以太币。
- 可以通过abi.encodeWithSignature方法来编码函数签名和参数。
- 可以返回调用是否成功以及调用的返回值。
- 可以设置gas limit。

#### staticcall方法:
- 与call方法类似，但不允许修改区块链的状态。
- 用于读取其他合约的状态变量，而不会改变状态。
- 如果被调用的函数尝试修改状态，staticcall会立即回滚。

#### delegatecall方法:
- 与call方法类似.
- 用于在另一个合约中执行函数，但修改调用合约的状态变量。
- 被调用合约msg.sender和msg.value与调用合约msg.sender和msg.value相同。
- 也可以返回调用是否成功以及返回值。

三种调用方法在操作码层面分别对应了不同的操作码，它们在燃气消耗上没有区别。

```
F1  CALL               | warm 100, cold 2600      
FA  STATICCALL         | warm 100, cold 2600 
F4  DELEGATECALL       | warm 100, cold 2600 
```
staticcall只能用于读取其他合约状态，不能对链上状态有修改。

### call方法 vs delegatecall方法

delegatecall方法和call方法最大的不同是call方法修改的是目标合约storage的状态，而delegatecall方法调用目标合约的代码，最终修改的是自身的starage状态。当合约B通过delegatecall调用合约A时，EVM在给创建A的执行上下文时将A的storageObject，msg.sender和msg.value信息传递给新的执行上下文，B delegatecall调用A合约时，等于B合约在用合约B的方法在改变自己的状态。

看一下这个简单案例

```js

```

### 推荐阅读
- [EVM Deep Dives 5: Another Weapon in the EVM Hackers Arsenal - The Power of Delegate Call](https://noxx.substack.com/p/evm-deep-dives-the-path-to-shadowy-a5f)