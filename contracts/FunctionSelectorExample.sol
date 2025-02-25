//SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.28;

contract FunctionSelectorExample {

    //两个函数，求平方值和求两倍值，实现使用函数选择器动态调用

    function square(uint x) public pure returns(uint){
        return x*x;
    }

    function double(uint x) public pure returns(uint){
        return x*2;
    }

    function getSelectorSquare() external pure returns (bytes4) {
        return this.square.selector;
    }
    function getSelectorDouble() external  pure returns (bytes4) {
        return bytes4(keccak256("double(uint256)"));
    }
    function execute(bytes4 selector, uint x) external returns(uint z){
        (bool success,bytes memory data) = address(this).call(abi.encodeWithSelector(seletor,x));
        require(success,"call failed");
        z = abi.decode(data,(uint));
    }
}