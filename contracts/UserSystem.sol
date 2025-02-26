//SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.28;


// 任务 1：用映射存储和操作余额。
// 任务 2：扩展映射存储交易历史，用数组模拟键集合。
// 任务 3：用映射和数组组合来实现积分排行榜，并排序。

contract UserSystem {
    //定义映射存储用户以及余额
    mapping(address => uint) private balances;

    //定义交易历史映射
    mapping(address => uint[]) private transactionHistory;

    //定义一个用户数组
    address[] private users;

    //任务: 增加和查询余额和记录交易历史
    function deposit(uint amount) public {
        //如果是第一次记录该用户，将用户添加到用户组中
        if(balances[msg.sender] == 0){
            users.push(msg.sender);
        }
        balances[msg.sender] += amount;
        //记录交易历史
        transactionHistory[msg.sender].push(amount);
    }

    //任务：查询余额
    function getBanlance() public view returns(uint){
        return balances[msg.sender];
    }

    //任务：实现积分榜排行
    function getLeaderBoard() public view returns (address[] memory){
        address[] memory sortedUsers = users;
        for(uint i = 0;i<sortedUsers.length;i++){
            for(uint j = i+1;j<sortedUsers.length;j++){
                if(balances[sortedUsers[i]] < balances[sortedUsers[j]]){
                    address temp = sortedUsers[i];
                    sortedUsers[i] = sortedUsers[j];
                    sortedUsers[j] = temp;
                }
            }
        }
        return sortedUsers;
    }
}