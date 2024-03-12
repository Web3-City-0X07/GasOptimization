// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract Case_101_A {
    uint256 public number;
    // 1th 43794 = 21064 + 22730
    // 2th 26694 = 21064 + 5630 | 30699 gas limit
    function inc() public returns (uint256) {
        number += 1; // step 30-99 | 5215 gas | 9519 gas left
        return number; // 119 gas | 4304 gas left
    }
}

contract Case_101_B {
    uint256 public number;
    // 1th 43781(tx-cost) = 21064 + 22717(execution gas)
    // 2th 26681(tx-cost) = 21064 + 5617(execution gas) | 30684 gas limit
    function inc() public returns (uint256) {
        number = number + 1; // step 30-94 5202 gas cost | 9504 gas left
        return number; // 119 gas | 4302 gas left
    }
}

contract Case_101_C {
    uint256 public number;
    // 1th 43631(tx-cost) = 21064 + 22567(execution gas)
    // 2th 26531(tx-cost) = 21064 + 5467(execution gas) | 30511 gas limit
    function inc() public returns (uint256) {
        return number++; // step 30-83 5171 gas cost | 9331 gas left
    }
}

contract Case_101_D {
    uint256 public number;
    // 1th 43625(tx-cost) = 21064 + 22561(execution gas)
    // 2th 26525(tx-cost) = 21064 + 5461(execution gas) | 30504 gas limit
    function inc() public returns (uint256) {
        return ++number; // step 30-81 5165 gas cost | 9324 gas left
    }
}

contract Case_101_E {
    uint256 public number;
    // 1th 43505(tx-cost) = 21064 + 22441(execution gas)
    // 2th 26405(tx-cost) = 21064 + 5341(execution gas) | 30366 gas limit
    function inc() public returns (uint256) {
        unchecked { return ++number; } // step 30-45 5045 gas cost | 9186 gas left
    }
}