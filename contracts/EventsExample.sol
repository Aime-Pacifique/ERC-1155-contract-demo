// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract EventExample{

    event NewUsereRegistered(address indexed user,string username);

    struct User{
        string username;
        uint256 age;
    }
    
    mapping (address => User) public  users;

    function registerUser(string memory _username,uint256 age) public {
        User storage newUser= users[msg.sender];
        newUser.username= _username;
        newUser.age= age;
         
         emit NewUsereRegistered(msg.sender, _username);
    }
} 