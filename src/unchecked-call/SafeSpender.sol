// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "./Token.sol";

contract SafeSpender {
    using SafeERC20 for IERC20;

    IERC20 public token;

    constructor(IERC20 _token) {
        token = _token;
    }

    function pay(address to, uint256 amount) external {
        token.safeTransfer(to, amount); // reverts if transfer fails/returns false
    }
}
