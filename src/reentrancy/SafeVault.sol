// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract SafeVault is ReentrancyGuard {
    mapping(address => uint256) public balances;

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() external nonReentrant {
        uint256 bal = balances[msg.sender];
        require(bal > 0, "no funds");

        // 1) Effects: Zero out the balance first
        balances[msg.sender] = 0;

        // 2) Interactions: now safely transfer ETH
        (bool ok, ) = msg.sender.call{value: bal}("");
        require(ok, "send failed");
    }

}
