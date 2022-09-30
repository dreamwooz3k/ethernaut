// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.0;

import "forge-std/Test.sol";
import "../src/Counter.sol";

contract CounterTest is Test {
    GatekeeperOne public a;
    function setUp() public {
       a = new GatekeeperOne();
    }

    function testIncrement() public 
    {
        a.enter(0x0100000000002204);
    }
}
