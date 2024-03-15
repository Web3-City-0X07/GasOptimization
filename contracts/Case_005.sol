// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Case_005 {
    function a() public payable {
        uint256[512] memory numbers;
        numbers[511] = 1;
    }

    function b() public payable {
        uint256[1024] memory numbers;
        numbers[1023] = 1;
    }

    function c() public payable {
        uint256[1536] memory numbers;
        numbers[1535] = 1;
    }

    function d() public payable {
        uint256[2048] memory numbers;
        numbers[2047] = 1;
    }

    function e() public payable {
        uint256[3072] memory numbers;
        numbers[3071] = 1;
    }
}