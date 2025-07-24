
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;


contract Calculator{

uint256 result =0;

function add(uint256 x) public {
    result += x;
}
function mul(uint256 x) public {
result *= x;
}

function divide(uint256 x) public {
    if (x==0){
        revert("Division by zero");
    }  
    result /= x;
}

function subtract(uint256 x) public {
result -=x;
}


function get () public view returns (uint256)  {
    return   result;
}
}

