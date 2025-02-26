// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;


// 接口的基本实现：
// 编写一个接口 IVault，定义存款和取款的函数，然后编写一个合约 Bank 实现该接口，管理用户的存款和取款。
interface IVault {
    function deposit() external payable;
    function withdraw(uint amount) external;
    function getBalance(address user) external view returns (uint);
}

contract Bank is IVault{
    mapping(address => uint) private balances;
    //存款
    function deposit() external payable override{
        require(msg.value > 0,"amount <0");
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint amount) external override{
        require(balances[msg.sender] > 0);
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    function getBalance(address user) external view override returns(uint){
        return balances[user];
    }
}


// 合约间通信：
// 编写一个代币合约 MyToken，然后编写一个奖励合约 Reward，通过 MyToken 合约给用户发放代币奖励。
//solidity可以隐式的实现接口，即当一个合约中的方法，提供了接口中相同的函数，就代表了它实现了这个接口

// 定义 MyToken 接口
interface IMyToken {
    function transfer(address to, uint256 amount) external;
}

contract Mytoken{
    mapping(address => uint) balances;
    address public owner;
    event Transfer(address indexed from, address indexed to, uint value);
    constructor(){
        owner = msg.sender;
    }
    function mint(address to,uint amount) external {
        require(msg.sender == owner , "only owner can do this");
        balances[to] += amount;
        emit Transfer(address(0), to, amount);
    }
    function transfer(address to ,uint256 amount) external {
        require(balances[msg.sender] > amount , "insufficent balance");
        balances[to] += amount;
        emit Transfer(msg.sender, to, amount);
    }
}

contract Reward {
    IMyToken public token;

    constructor(address tokenAddress) {
        token =  IMyToken(tokenAddress);
    }
    function giveReward(address user,uint amount) external{
        token.transfer(user, amount);
    }
}



// 使用标准接口：
// 实现一个符合 ERC20 标准的代币合约，并通过 ERC20 接口与钱包合约进行交互。

