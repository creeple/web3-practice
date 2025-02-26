//SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.28;

contract ProductOrderManagement{

    struct Product {
        uint id;
        string name;
        uint price;
        uint stock;
    }

    struct Order {
        uint orderId;
        uint prodcutId;
        address buyer;
    }

    //需要两个映射，存储产品信息和订单信息
    mapping(uint => Product) private products;
    mapping(uint => Order) private orders;

    uint private nextProductId = 1;
    uint private nextOrderId = 1;

    //新增产品
    function addProduct(string memory name, uint price, uint stock) public {
        products[nextProductId] = Product(nextProductId,name,price,stock);
        nextProductId++;
    }
    //修改产品
    function updateProduct(uint productId,string memory name, uint price, uint stock ) public {
        require(products[productId].id !=0,"product not exist");
        products[productId] = Product(productId,name,price,stock);
    }

}
contract UserManagement {

    struct User{
        string name;
        uint balance;
    
    }

}