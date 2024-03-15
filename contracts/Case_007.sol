// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

interface IA {
    function inc(uint256 n) external payable;
    function getNum1() external view returns (uint256);
}

contract A is IA {
    uint256 private num1;
    uint256 public num2;
    event CallInfo(address sender, uint256 value, uint256 n);

    // function signature 0x812600df
    function inc(uint256 n) external payable {
        num1 += n;
        num2 += n;

        emit CallInfo(msg.sender, msg.value, n);
    }

    // function signature 0x306a23c7
    function getNum1() external view returns (uint256) {
        return num1;
    }
}

contract B {
    uint256 private num1;
    uint256 public num2;

    function a1(address _caller, uint256 n) public {
        (bool success, ) = _caller.call(abi.encodeWithSignature('inc(uint256)', n));
        if (!success) {
            revert();
        }
    }

    function a2(address _caller, uint256 n) public {
        (bool success, ) = _caller.call(abi.encodeWithSelector(0x812600df, n));
        if (!success) {
            revert();
        }
    }

    function a3(address _caller, uint256 n) public {
        IA(_caller).inc(n);
    }

    function a4(address _caller, uint256 n) public {
        A(_caller).inc(n);
    }

    function b1(address _caller, uint256 n) public {
        // staticCall
        uint256 _num1 = IA(_caller).getNum1();
        IA(_caller).inc(_num1 + n);
    }

    function b2(address _caller, uint256 n) public {
        // staticCall
        (bool success, bytes memory m) = _caller.staticcall(abi.encodeWithSelector(0x306a23c7));
        if (!success) {
            revert();
        }
        uint256 _uintM = uint256(bytes32(m));
        (success, ) = _caller.call(abi.encodeWithSelector(0x812600df, _uintM + n));
        if (!success) {
            revert();
        }
    }

    // c incWithDelegatecall
    function c(address _caller, uint256 n) public {
        (bool success, ) = _caller.delegatecall(abi.encodeWithSignature('inc(uint256)', n));
        if (!success) {
            revert();
        }
    }
}