// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MonkeyGameToken is ERC20,Ownable {
    address private devWallet;
    uint256 public constant ENTRY_FEE = 25 * 10**18;
    uint256 public constant RESTART_FEE_PERCENTAGE = 40;
    uint256 public constant BURN_PERCENTAGE = 90;
    uint256 public constant DEV_FEE_PERCENTAGE = 10;
    uint256 public constant MAX_TRIES_PER_DAY = 10;
    uint256 public constant SECONDS_PER_DAY = 86400;

    mapping(address => uint256) public lastTry;
    mapping(address => uint256) public tryCount;

    constructor(string memory name, string memory symbol, address _devWallet) ERC20(name, symbol) {
        devWallet = _devWallet;
    }

    function mint(address to, uint256 _amount) public onlyOwner {
        _mint(to, _amount);
    }

    function bulkAdd(address[] memory recipients, uint256[] memory amounts) external onlyOwner {
        require(recipients.length == amounts.length, "Arrays must have the same length");

        for (uint256 i = 0; i < recipients.length; i++) {
            _mint(recipients[i], amounts[i]);
        }
    }

    function bulkRemove(address[] memory recipients, uint256[] memory amounts) external onlyOwner {
        require(recipients.length == amounts.length, "Arrays must have the same length");

        for (uint256 i = 0; i < recipients.length; i++) {
            _burn(recipients[i], amounts[i]);
        }
    }

    function play(uint256 level) external {
        require(tryCount[msg.sender] < MAX_TRIES_PER_DAY, "You have reached your daily limit");
        require(lastTry[msg.sender] + SECONDS_PER_DAY < block.timestamp, "Please wait 24 hours before trying again");
        require(balanceOf(msg.sender) >= ENTRY_FEE, "You do not have enough tokens to play");

        lastTry[msg.sender] = block.timestamp;
        tryCount[msg.sender]++;

        _transfer(msg.sender, address(0), ENTRY_FEE * BURN_PERCENTAGE / 100); // Burn 90%
        _transfer(msg.sender, devWallet, ENTRY_FEE * DEV_FEE_PERCENTAGE / 100); // Send 10% to dev wallet

        uint256 reward = level * 10**18; // Linear progression of reward
        _mint(msg.sender, reward);
    }

    function restart(uint256 level) external {
        require(balanceOf(msg.sender) >= level * 10**18 * RESTART_FEE_PERCENTAGE / 100, "You do not have enough tokens to restart");

        uint256 fee = level * 10**18 * RESTART_FEE_PERCENTAGE / 100;

        _transfer(msg.sender, address(0), fee * BURN_PERCENTAGE / 100); // Burn 90%
        _transfer(msg.sender, devWallet, fee * DEV_FEE_PERCENTAGE / 100); // Send 10% to dev wallet

        uint256 reward = level * 10**18 - fee; // Potential reward minus fee
        _mint(msg.sender, reward);
    }
}
