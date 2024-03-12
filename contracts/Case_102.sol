// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

error NumberError();
error NumberInvaild(uint256);

contract Case_102 {
    uint256 public number;

    function setNumber(uint256 n) public {
        require(n > 100, "number must gt 100");
        number = n;
    }

    function setNumber1(uint256 n) public {
        if (n < 10) {
            revert NumberError();
        }
        number = n;
    }

    function setNumber2(uint256 n) public {
        if (n < 10) {
            revert NumberInvaild(n);
        }
        number = n;
    }
}
