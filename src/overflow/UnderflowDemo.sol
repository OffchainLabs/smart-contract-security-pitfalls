// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

contract UnderflowDemo {
    mapping(address => uint256) public balances;

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    // ❌ Intentionally buggy: reintroduces underflow with unchecked
    function withdrawUnchecked(uint256 amount) external {
        uint256 bal = balances[msg.sender];
        unchecked {
            // If amount > bal, this wraps to a huge number instead of reverting
            balances[msg.sender] = bal - amount;
        }
        payable(msg.sender).transfer(amount);
    }

    // ✅ Safe by default in Solidity >= 0.8 (reverts on underflow)
    function withdrawChecked(uint256 amount) external {
        balances[msg.sender] -= amount; // reverts if amount > balance
        payable(msg.sender).transfer(amount);
    }
}
