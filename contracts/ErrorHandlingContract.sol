//SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.28;

contract ErrorHandlingContract {
    error ValueTooLow(uint sent,uint required);

    error DivivsionByZero();

    error Unauthorized(address caller);

    uint public storedValue;

    address public owner;
    constructor(){
        owner = msg.sender;
    }

    //自定义错误返回
    function setValue(uint _value) public {
        //回滚并返回错误信息

        if(_value <10){
            revert ValueTooLow(_value,10);
        }
        storedValue = _value;
    }

    function onlyOwner() public view{
        if(msg.sender != owner){
            revert Unauthorized(msg.sender);
        }
    }
    //使用require
    function requireTest(uint a,uint b) public pure returns (uint z){
        require(b!=0,"cannot divide by zero");
        z = a/b;
    }
    function callExternalContract(address con, uint amount) public returns (bool){
        ExternalContract ext = ExternalContract(con);
        try ext.externalFunction(amount) returns (bool success){
            return success;
        }catch Error(string memory reason){
            // 处理 require 或 revert 失败
            emit ExternalCallFailed(reason);
            return false;
        }catch(bytes memory){
             // 处理 assert 失败（不可恢复错误）
            emit ExternalCallFailed("Low-level error");
            return false;

        }
    }

    // 事件：外部合约调用失败
    event ExternalCallFailed(string reason);

}

// 外部合约，用于测试 try/catch
contract ExternalContract {
    error InvalidAmount(uint256 amount);

    function externalFunction(uint256 amount) public pure returns (bool) {
        if (amount < 100) {
            revert InvalidAmount(amount);
        }
        return true;
    }
}
