// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0;

contract Case201 {
    uint256 number;

    function store(uint256 n) external payable {
        number = n;
    }
}