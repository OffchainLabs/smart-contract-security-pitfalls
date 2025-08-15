// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

contract NoAccess {
    address public owner;
    uint256 public criticalParam;

    constructor() {
        owner = msg.sender;
    }

    // ❌ Anyone can change the critical parameter
    function setCriticalParam(uint256 x) external {
        criticalParam = x;
    }

    // ❌ Owner can be overwritten by anyone
    function setOwner(address newOwner) external {
        owner = newOwner;
    }
}
