# 从最简单的合约入手看合约汇编代码-part1

想要从汇编字节指令的层面来了解合约功能，一定要从最简单的功能开始
```js
pragma solidity >=0.8.0;

contract Case201 {
    uint256 number;

    function store() external payable {
        number = 9;
    }
}
```

##### 燃气消耗情况
- transaction cost	43254 gas 
- execution cost	22190 gas 

这段代码在Remix中的汇编指令如下
```js
.code
//*************************************** */
    // 标准操作，为内存使用做准备
    // 18 gas cost
    PUSH 80			
    PUSH 40			
    MSTORE 	
//*************************************** */
   	// 检查方法签名小于4bytes，执行tag 1回滚
    // 21 gas cost
    PUSH 4			
    CALLDATASIZE 			
    LT 			
    PUSH [tag] 1			
    JUMPI 		
//*************************************** */ 
    // 如果签名是store()就执行tag 2
    // 33 gas cost
    PUSH 0			
    CALLDATALOAD 			
    PUSH E0			
    SHR 			
    DUP1 			
    PUSH 975057E7			
    EQ 			
    PUSH [tag] 2			
    JUMPI 	
//*************************************** */ 
// 72 gas cost
//*************************************** */ 
// tag 1 失败回滚    		
tag 1			
    JUMPDEST 			
    PUSH 0			
    DUP1 			
    REVERT 	
//*************************************** */ 
// tag 2 执行赋值并存储	
// 22100 + 17 gas cost
tag 2			function store() external payable
    JUMPDEST 			
    PUSH [tag] 3			
    PUSH 9			9
    PUSH 0			number
    SSTORE 			number = 9
    JUMP 	
//*************************************** */ 	
// tag 3 执行完毕	
tag 3			
    JUMPDEST 			
    STOP 			
.data
```
当使用solc编译后，会有略微不同的汇编，但逻辑是一样的
`
solc --bin --asm --optimize contracts/Case_201.sol
`
```
assembly
    mstore(0x40, 0x80)
    jumpi(tag_1, lt(calldatasize, 0x04))
    shr(0xe0, calldataload(0x00))
    dup1
    0x975057e7
    eq
    tag_2
    jumpi
tag_1:
    0x00
    dup1
    revert
/* "contracts/Case_201.sol":109:170  function store() external payable {... */
tag_2:
    tag_3
    /* "contracts/Case_201.sol":162:163  9 */
    0x09
    /* "contracts/Case_201.sol":153:159  number */
    0x00
    /* "contracts/Case_201.sol":153:163  number = 9 */
    sstore
    /* "contracts/Case_201.sol":109:170  function store() external payable {... */
    jump
tag_3:
    stop
```