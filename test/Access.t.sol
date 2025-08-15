// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "forge-std/Test.sol";
import "../../src/access/NoAccess.sol";
import "../../src/access/OwnableFixed.sol";

contract AccessTest is Test {
    NoAccess na;
    OwnableFixed fixedC;
    address attacker = address(0xBAD);

    function setUp() public {
        na = new NoAccess();
        fixedC = new OwnableFixed();
    }

    function testAnyoneCanChangeCriticalParam_Vulnerable() public {
        vm.prank(attacker);
        na.setCriticalParam(42);
        assertEq(na.criticalParam(), 42);
        // And they can steal ownership, too
        vm.prank(attacker);
        na.setOwner(attacker);
        assertEq(na.owner(), attacker);
    }

    function testOnlyOwnerCanChangeCriticalParam_Fixed() public {
        vm.prank(attacker);
        vm.expectRevert(); // onlyOwner
        fixedC.setCriticalParam(42);
        fixedC.setCriticalParam(7); // owner (this) can set
        assertEq(fixedC.criticalParam(), 7);
    }
}
