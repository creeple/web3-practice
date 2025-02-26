//SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.28;

contract MappingExample {
    mapping(address => uint) public banlances;

    function update(uint newBanlance) public {
        banlances[msg.sender] = newBanlance;
    }
}

contract MappingUser {
    function fun() public returns (uint) {
        MappingExample example = new MappingExample();
        example.update(100);

        return example.banlances(address(this));
    }
}