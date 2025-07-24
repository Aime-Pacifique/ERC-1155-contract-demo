// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Profile {
    struct UserProfile {
        string displayName;
        string bio;
    }

    
    mapping(address => UserProfile) public profiles;

    modifier notAlreadyRegistered() {
        UserProfile memory userProfileTemp= profiles[msg.sender];
        require(bytes(userProfileTemp.displayName).length  ==0,"Already registered");

        _;
    }

    function setProfile(string memory _displayName, string memory _bio) public notAlreadyRegistered {
        profiles[msg.sender] = UserProfile({
            displayName: _displayName,
            bio:_bio
        });

    }
    function getProfile(address _user) public view returns (UserProfile memory) {
        return profiles[_user];
    }
}