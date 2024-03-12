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
