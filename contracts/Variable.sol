//SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.28;

contract Variable{
    uint storageData; //状态变量
    constructor() public {
        storageData = 10;
    }

    function getResult() public view returns(uint) {
        uint a = 1;
        uint b = 2;
        return a+b;
    }

    
}