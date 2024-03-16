// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Case008 {
    uint256 private number;

    constructor(uint256 n) payable {
        number = n;
    }

    function inc() external payable {
        ++number;
    }
}