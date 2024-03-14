// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

contract Case_109 {
    // uint256 constant v = 0;
    uint constant Ether = 10 ** 18;
    
    event Transfer(address, address, uint256);

    // 0xa9059cbb
    function transfer(address to, uint256 value) public virtual returns (bool) {
        emit Transfer(msg.sender, to, value);
        return true;
    }

    // 0x00005cfc
    function transfer_35177(address to) public payable returns (bool) {
        emit Transfer(msg.sender, to, msg.value * Ether);
        return true;
    }

    // 0x0000988c
    function transfer_16049(bytes32 to) public returns (bool){
        emit Transfer(msg.sender, address(bytes20(to << 96)), uint(uint96(bytes12(to))) * (10 ** 18));
        return true;
    }

    // 0x0000ddd0
    function a_transfer_73336(address to) public payable returns (bool) {
        emit Transfer(msg.sender, to, msg.value * (10 ** 18));
        return true;
    }

    // 0x00004683
    function transfer_86559(address to, uint256 value) public virtual returns (bool) {
        emit Transfer(msg.sender, to, value);
        return true;
    }

    // 0x0000e132 
    function transfer_71446(address to, uint256 value) public virtual returns (bool) {
        emit Transfer(msg.sender, to, value);
        return true;
    }
}

