// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "@openzeppelin/contracts/access/Ownable.sol";

contract OwnableFixed is Ownable {
    uint256 public criticalParam;

    constructor() Ownable(msg.sender) {}

    function setCriticalParam(uint256 x) external onlyOwner {
        criticalParam = x;
    }
}
