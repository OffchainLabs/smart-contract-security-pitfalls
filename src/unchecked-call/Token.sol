// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

interface IERC20Like {
    function transfer(address to, uint256 value) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

contract MockTokenFailing {
    mapping(address => uint256) public balances;

    function mint(address to, uint256 amount) external {
        balances[to] += amount;
    }

    function transfer(address to, uint256 value) external returns (bool) {
        // simulate a failure by always returning false without changing balances
        to; value;
        return false;
    }

    function balanceOf(address a) external view returns (uint256) {
        return balances[a];
    }
}
