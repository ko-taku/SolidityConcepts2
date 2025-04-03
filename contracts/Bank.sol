// SPDX-License-Identifier: MIT

import "./Vault.sol";

pragma solidity ^0.8.0;

contract Bank is Vault {
    event Withdrawn(address indexed user, uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call withdraw.");
        _;
    }

    function withdraw(uint256 _amount) public onlyOwner {
        require(_amount <= sentValue, "Insufficient balance in Vault.");
        sentValue -= _amount;
        (bool success, ) = payable(msg.sender).call{value: _amount}("");
        require(success, "Failed to send ether");
        emit Withdrawn(owner, _amount);
    }
}
