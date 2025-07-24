// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;


contract PausableToken {

    address public  owner;
    bool public paused;
    mapping (address => uint) balances;

    constructor() {
        owner=msg.sender;
        paused=false;
        balances[owner]= 1000;
    }

    modifier  onlyOwner {
        require(msg.sender == owner, "Only contract owners are allowed");
        _;
    }

    modifier notPaused{
        require(paused == false,"Contract is  paused");
        _;
    }

    function pause() public  onlyOwner {
        paused=true;
    }

    function unPause() public  onlyOwner{
        paused=false;
    }

    


    function transfer(address _to,uint256 _amount) public notPaused {
        require(balances[msg.sender] >= _amount,"Insufficient balance");
        balances[msg.sender] -= _amount;
        balances[_to] += _amount;
    }
}