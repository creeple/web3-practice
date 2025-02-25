//SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.28;

contract SimpleWallet {
    mapping(address => uint) public balances;

     function deposit() public payable {
        balances[msg.sender] += msg.value;
     }

     function withdraw(uint amount) public {
        require(balances[msg.sender] > amount,"insufficent balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
     }

     function checkBalance() public view returns (uint256) {
        return balances[msg.sender];
     }
}