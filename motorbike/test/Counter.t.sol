// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/exploit.sol";

contract abc is Test {
    exploit public ex;
    ex_contract public attack_addr;
    Motorbike public mot;
    function setUp() public {
       ex = new exploit();
       attack_addr = new ex_contract();
       mot = Motorbike(0x8424FF1ece95877a1977c7af9D85eb795CBf10b5);
       vm.deal(address(this), 5000 ether);
    }

    function testIncrement() public {
        //ex.upgradeToAndCall(address(attack_addr), abi.encodeWithSignature("attack()"));
        mot.initialize();
    }
}
