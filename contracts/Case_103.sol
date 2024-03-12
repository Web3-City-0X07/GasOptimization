// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Case_103 {
    uint public counter;
    function a(string calldata s) public returns (string calldata) {
        ++counter;
        return s;
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