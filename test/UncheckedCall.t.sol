// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "forge-std/Test.sol";
import "../../src/unchecked-call/Token.sol";
import "../../src/unchecked-call/VulnerableSpender.sol";
import "../../src/unchecked-call/SafeSpender.sol";

contract UncheckedCallTest is Test {
    MockTokenFailing token;
    VulnerableSpender vuln;
    SafeSpender safe;
    address alice = address(0xA11CE);
    address bob = address(0xB0B);

    function setUp() public {
        token = new MockTokenFailing();
        vuln = new VulnerableSpender(IERC20Like(address(token)));
        safe = new SafeSpender(IERC20(address(token)));
        token.mint(alice, 100);
    }

    function testVulnerableSpenderThinksItPaid() public {
        vm.prank(alice);
        vuln.pay(bob, 10);
        // Transfer returned false and balances didn't change
        assertEq(token.balanceOf(bob), 0, "bob didn't receive tokens");
    }

    function testSafeSpenderRevertsOnFailedTransfer() public {
        vm.prank(alice);
        vm.expectRevert(); // SafeERC20 will revert because transfer returns false
        safe.pay(bob, 10);
    }
}
