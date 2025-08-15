// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "./Token.sol";

contract VulnerableSpender {
    IERC20Like public token;

    constructor(IERC20Like _token) {
        token = _token;
    }

    // ❌ Ignores return value; will think transfer succeeded even when false
    function pay(address to, uint256 amount) external {
        token.transfer(to, amount);
        // continue logic assuming success...
    }
}
