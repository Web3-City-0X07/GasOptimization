# use memery cache

contracts/Case_109.sol
```js
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

contract Case_109 {
    uint256[] public numbers;

    event Total(uint256);

    function init(uint256[] memory _numbers) public {
        numbers = _numbers;
    }

    function add(uint256 _number) public {
        numbers.push(_number);
    }

    function sum0() public returns (uint256) {
        uint256 total = 0;
        for (uint256 i = 0; i < numbers.length; i++) {
            total += numbers[i];
        }
        emit Total(total);
        return total;
    }

    function sum1() public returns (uint256) {
        uint256 total = 0;
        uint256 _len = numbers.length;
        for (uint256 i = 0; i < _len; i++) {
            total += numbers[i];
        }
        emit Total(total);
        return total;
    }

    // 方法参考了文章 https://dev.to/jamiescript/gas-saving-techniques-in-solidity-324c
    function sum2() public returns (uint256) {
        uint256 total = 0;
        uint256 _len = numbers.length;
        uint256[] memory _numbers = numbers;
        for (uint256 i = 0; i < _len; i++) {
            total += _numbers[i];
        }
        emit Total(total);
        return total;
    }
}
```

sum2是网上一个博主提供的写法，比sum1多了一个复制数据给memory，其实是没有必要的，其实这个案例节省燃气的地方就是把多次读numbers.length，变成只读一次storage。
```js

// 37522 limit | 32627 cost | 21064 start cost | 11563 exec cos
// step 0-29 119 gas cost | 16458 gas left when step 0
function sum0() public returns (uint256) { // step 30-34 | 189 gas | 16399 left when step 30
    uint256 total = 0; // step 35 | 10 gas | 16322 gas left when step 35
    for (uint256 i = 0; i < numbers.length; i++) {
        total += numbers[i];
    }
    // 10047 gas cost from stop 35
    emit Total(total); // step 344 | 1188 gas | 6275 gas left when step 344
    return total;
}

// 37218 limit | 32363 cost | 21064 start cost | 11299 exec cost
// step 0-39 | 163 gas left when step 0
function sum1() public returns (uint256) { // step 40 | 15991 gas left when step 40
    uint256 total = 0; // step 45 | 10 gas | 15974 gas left when step 45
    uint256 _len = numbers.length;
    for (uint256 i = 0; i < _len; i++) {
        total += numbers[i];
    }
    // 9737 gas cost from stop 45
    emit Total(total); // step 346 | 1188 gas | 6237 gas left when step 346
    return total;
}

// 这是网上一个博主提供的写法，比sum1多了一个复制数据给memory，其实是没有必要的；
// 37380 limit | 32504 cost | 21064 start cost | 11440 exec cos
// step 0-34 141 gas cost | 16316 gas left when step 0
function sum2() public returns (uint256) { // step 35 | 189 gas | 16175 gas left when step 35
    uint256 total = 0; // step 40 | 10 gas | 16158 gas left when step 40
    uint256 _len = numbers.length;
    uint256[] memory _numbers = numbers;
    for (uint256 i = 0; i < _len; i++) {
        total += _numbers[i];
    }
    // 9901 gas cost from stop 40
    emit Total(total); // step 435 | 1185 gas | 6257 gas left when step 346
    return total;
}

```