// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

contract VulnerableVault {
    mapping(address => uint256) public balances;

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() external {
        uint256 bal = balances[msg.sender];
        require(bal > 0, "no funds");
        // ❌ External call before state update
        (bool ok, ) = msg.sender.call{value: bal}("");
        require(ok, "send failed");
        // ❌ Effect after interaction (reentrancy bug)
        balances[msg.sender] = 0;
    }

    // helper
    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
