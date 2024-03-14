// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }

    function _contextSuffixLength() internal view virtual returns (uint256) {
        return 0;
    }
}

// File @openzeppelin/contracts/access/Ownable.sol@v5.0.2

// Original license: SPDX_License_Identifier: MIT
// OpenZeppelin Contracts (last updated v5.0.0) (access/Ownable.sol)

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * The initial owner is set to the address provided by the deployer. This can
 * later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
abstract contract Ownable is Context {
    address private _owner;

    /**
     * @dev The caller account is not authorized to perform an operation.
     */
    error OwnableUnauthorizedAccount(address account);

    /**
     * @dev The owner is not a valid owner account. (eg. `address(0)`)
     */
    error OwnableInvalidOwner(address owner);

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the address provided by the deployer as the initial owner.
     */
    constructor(address initialOwner) {
        if (initialOwner == address(0)) {
            revert OwnableInvalidOwner(address(0));
        }
        _transferOwnership(initialOwner);
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        _checkOwner();
        _;
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if the sender is not the owner.
     */
    function _checkOwner() internal view virtual {
        if (owner() != _msgSender()) {
            revert OwnableUnauthorizedAccount(_msgSender());
        }
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        if (newOwner == address(0)) {
            revert OwnableInvalidOwner(address(0));
        }
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Internal function without access restriction.
     */
    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}

interface IDonate {
    // 注册消息
    event Register(uint256 indexed userId, address indexed account);
    /**
     * 捐赠记录
     * @dev Emitted by donate submit
     *
     */
    event Donate(uint256 indexed userId, uint256 amount);
    /**
     * 某些情况下对用户做出惩罚记录
     * @dev Emitted by punish submit
     *
     * Note that {msg} 是 惩罚原因
     */
    event Punish(address indexed userId, uint256 amount, string msg);
    // 基本转移给自己的新账户
    event Transfer(address indexed from, address indexed to);
    /**
     * 积分验证
     * @dev Emitted when approval submit
     *
     * {serviceId} 服务机构ID
     * {score} 账户积分
     */
    event Approval(uint256 indexed userId, uint256 indexed serviceId, uint256 score);
    /**
     * 积分验证
     * @dev Emitted when approval submit
     *
     * {serviceId} 服务机构ID
     * {score} 账户积分
     * {minLimit} 服务机构要求分
     */
    event Approval(uint256 indexed userId, uint256 indexed serviceId, uint256 score, uint256 minLimit);

    function register(uint256 userId) external;
    function isRegisted(uint256 userId) external view returns (address);
    function transfer(uint256 userId, address to) external;
    function donate(uint256 userId, uint256 amount) external;
    function punish(uint256 userId, uint256 amount, string calldata msg) external;
    function scoreOf(address account) external view returns (uint256);
    function scoreOf(uint256 userId) external view returns (uint256);
    // 向某个机构验证记录，只需要验证积分值
    function approval(uint256 userId, uint256 to) external;
    // 向某个机构验证记录，需要验证积分值  >= value才可以
    function approval(uint256 userId, uint256 to, uint256 value) external;
}

contract DonateBlood is IDonate, Ownable {
    mapping(address => uint256) private score;
    mapping(uint256 => address) private users;

    error ScoreNotEnough(uint256 score);
    error HasRegisted();
    error NotRegisted();
    error Auth401();

    constructor()
        Ownable(msg.sender)
    {}

    function register(uint256 userId) external {
        // has registed
        if (uint160(users[userId]) != 0) {
            revert HasRegisted();
        }
        users[userId] = msg.sender;
        emit Register(userId, msg.sender);
    }

    function isRegisted(uint256 userId) view external returns (address) {
        return users[userId];
    }

    function transfer(uint256 userId, address to) external onlyOwner() {
        address account = users[userId];
        if (uint160(account) == 0) {
            revert NotRegisted();
        }
        address from = users[userId];
        emit Transfer(from, to);
    }

    function donate(uint256 userId, uint256 amount) external onlyOwner() {
        address account = users[userId];
        if (uint160(account) == 0) {
            revert NotRegisted();
        }
        score[account] += amount;
        emit Donate(userId, amount);
    }

    function punish(uint256 userId, uint256 amount, string calldata message) external onlyOwner() {
        address account = users[userId];
        if (uint160(account) == 0) {
            revert NotRegisted();
        }
        uint256 _score = score[account];
        if (_score < amount) {
            revert ScoreNotEnough(_score);
        }
        _score -= amount;
        emit Punish(account, amount, message);
    }

    function scoreOf(uint256 userId) external view returns (uint256) {
        address account = users[userId];
        if (uint160(account) == 0) {
            revert NotRegisted();
        }
        return score[account];
    }

    function scoreOf(address account) external view returns (uint256) {
        return score[account];
    }

    function approval(uint256 userId, uint256 to) external {
        address account = users[userId];
        if (uint160(account) == 0) {
            revert NotRegisted();
        }
        if (account != msg.sender) {
            revert Auth401();
        }
        emit Approval(userId, to, score[msg.sender]);
    }

    function approval(uint256 userId, uint256 to, uint256 amount) external {
        address account = users[userId];
        if (uint160(account) == 0) {
            revert NotRegisted();
        }
        if (account != msg.sender) {
            revert Auth401();
        }

        uint _score = score[account];
        if(_score < amount) {
            revert ScoreNotEnough(_score);
        }
        emit Approval(userId, to, _score, amount);
    }

}
