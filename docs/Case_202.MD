# 从最简单的合约入手看合约汇编代码-part2

想要从汇编字节指令的层面来了解合约功能，一定要从最简单的功能开始
```js
pragma solidity >=0.8.0;

contract Case202 {
    uint256 number;

    function store(uint256 n) external payable {
        number = n;
    }
}
```

##### 燃气消耗情况
- transaction cost	43467 gas 
- execution cost	22263 gas 

这段代码在Remix中的汇编指令如下
```js
//*************************************** */ 
.code
    PUSH 80			
    PUSH 40			
    MSTORE 			
    PUSH 4			
    CALLDATASIZE 			
    LT 			
    PUSH [tag] 1			
    JUMPI 			
    PUSH 0			
    CALLDATALOAD 			
    PUSH E0			
    SHR 			
    DUP1 			
    PUSH 6057361D			
    EQ 			
    PUSH [tag] 2			
    JUMPI 			
tag 1			
    JUMPDEST 			
    PUSH 0			
    DUP1 			
    REVERT 			
tag 2			function store(uint256 n) exte...
    JUMPDEST 			
    PUSH [tag] 3			
    PUSH [tag] 4			
    CALLDATASIZE 			
    PUSH 4			
    PUSH [tag] 5			
    JUMP 			
tag 4			function store(uint256 n) exte...
    JUMPDEST 			
    PUSH 0			number
    SSTORE 			number = n
    JUMP 			
tag 3			function store(uint256 n) exte...
    JUMPDEST 			
    STOP 			
tag 5			
    JUMPDEST 			
    PUSH 0			 
    PUSH 20			
    DUP3 			
    DUP5 			   
    SUB 			
    SLT 			
    ISZERO 			
    PUSH [tag] 10			
    JUMPI 			
    PUSH 0			
    DUP1 			
    REVERT 		
tag 10			
    JUMPDEST 			
    POP 			
    CALLDATALOAD 		
    SWAP2 		
    SWAP1 			
    POP 			
    JUMP 			
.data
```
