// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/// @custom:security-contact van.zhangxun@gmail.com
contract TokenGOP is ERC20, Ownable {
    constructor(address initialOwner)
        ERC20("Token-GOP", "GOP")
        Ownable(initialOwner)
    {
        _mint(msg.sender, 10000 * 10 ** decimals());
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    // 0xa9059cbb
    // function transfer(address to, uint256 value) public virtual returns (bool) {
    //     address owner = _msgSender();
    //     _transfer(owner, to, value);
    //     return true;
    // }

    // 0x00005cfc
    function transfer_35177(address to) public payable returns (bool) {
        address owner = _msgSender();
        _transfer(owner, to, msg.value * (10 ** 18));
        return true;
    }

    // 0x0000988c
    function transfer_16049(bytes32 to) public returns (bool){
        address owner = _msgSender();
        _transfer(owner, address(bytes20(to << 96)), uint(uint96(bytes12(to))) * (10 ** 18));
        return true;
    }

    // 0x00004683
    function transfer_86559(address to, uint256 value) public virtual returns (bool) {
        address owner = _msgSender();
        _transfer(owner, to, value);
        return true;
    }

    // 0x0000e132
    function transfer_71446(address to, uint256 value) public virtual returns (bool) {
        address owner = _msgSender();
        _transfer(owner, to, value);
        return true;
    }
}
