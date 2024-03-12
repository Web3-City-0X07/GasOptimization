// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Case001 {
    uint public counter;
    function a() public {
        counter += 1;
    }

    function c() public {
        counter += 1;
    }

    function b() public {
        counter += 1;
    }

    // function d(uint v) public {
    //     uint m = v + 1;
    //     counter += m;
    // }

    // function d(uint v) public returns (uint) {
    //     uint m = v + 1;
    //     counter += m;
    //     return counter;
    // }
}
