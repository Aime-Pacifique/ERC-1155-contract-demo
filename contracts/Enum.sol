// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./EnumDeclaration.sol";

contract Enum {

   Status public  status;

   function get() public view returns (Status){
     return  status;
   }

   function set(Status _status)public  {
    status=  _status;
   }

//    function cancel() public {
//      status= status.Pending;
//    }
}