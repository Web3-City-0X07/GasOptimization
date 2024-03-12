
# calldata vs memory

### 源码

```js
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Case_103 {
    uint public counter;
    function a(string calldata s) public returns (string calldata) {
        ++counter;
        return s; //string.concat('receive:', s);
    }

    function b(string calldata s) public returns (string memory) {
        ++counter;
        return s; //string.concat('receive:', s);
    }

    function c(string memory s) public returns (string memory) {
        ++counter;
        return s; // string.concat('receive:', s);
    }
}
```

### 结果分析

```js
contract Case_103 {
    uint public counter;
    // 31669 gas limit | 27538 cost | start cost 21532 | exec cost 6006
    // step 0-25 | 96 gas | 10137 left when step start
    function a(string calldata s) public returns (string calldata) { // step 26-129 | 343 gas | 10041 left when step start
        ++counter; // step 130-179 | 5148 gas | 9698 left when step start
        return s; // step 179-190 | 37 gas | 4550 left when step start
    } // step 191-311 | 382 gas | 4513 left when step start
    // 4131 left

    // 32097 gas limit | 27910 cost | start cost 21532 | exec cost 6378
    // step 0-39 | 162 gas | 10565 left when step start
    function b(string calldata s) public returns (string memory) { // step 40-143 | 341 gas | 10402 left when step start
        ++counter; // step 144-192 | 5148 gas | 10061 left when step start
        return s; // step 193-260 | 213 gas | 4913 left when step start
    } // step 261-422 | 512 gas | 4699 gas left
    // 4187 left

    // 32364 gas limit | 28142 cost | start cost 21532 | exec cost 6610
    // step 0-29 | 118 gas | 10832 left when step start
    function c(string memory s) public returns (string memory) { // step 30-143 | 806 gas | 10713 left when step start
        ++counter; // step 276-192 | 5148 gas | 9907 left when step start
        return s; // step 325-332 | 24 gas | 4759 left when step start
    } // step 3323-494 | 512 gas | 4734 gas left
    // 4222 left
}

```

### 更多
返回calldata很少被用到，除非你直接返回某个参数的时候，当你的返回源自memory时，不能返回给calldata，calldata是只读的.
```
returns (string calldata)

// 不能返回给calldata
return string.concat('receive:', s)
```