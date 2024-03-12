// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Case000 {
    uint number;
    function store(uint256 n) public {
        number =n;
    }

    function retrieve() public view returns (uint256) {
        return number;
    }
}
