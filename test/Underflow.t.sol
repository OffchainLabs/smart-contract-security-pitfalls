// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "forge-std/Test.sol";
import "../../src/overflow/UnderflowDemo.sol";

contract UnderflowTest is Test {
    UnderflowDemo demo;
    address user = address(0xBEEF);

    function setUp() public {
        demo = new UnderflowDemo();
        vm.deal(user, 1 ether);
        vm.prank(user);
        demo.deposit{value: 1 ether}();
    }

    function testUncheckedUnderflowWraps() public {
        vm.prank(user);
        // With unchecked, this will not revert and will wrap balances[user]
        demo.withdrawUnchecked(2 ether);
        // balance mapping wrapped to a huge number
        uint256 bal = demo.balances(user);
        assertGt(bal, type(uint256).max / 2, "balance should have wrapped");
    }

    function testCheckedWithdrawRevertsOnUnderflow() public {
        vm.prank(user);
        vm.expectRevert();
        demo.withdrawChecked(2 ether);
    }
}
