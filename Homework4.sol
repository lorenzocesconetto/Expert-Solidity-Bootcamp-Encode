// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Store {
    struct payments {
        bool valid;
        bool checked;
        uint8 paymentType;
        address receiver;
        address sender;
        uint256 amount;
        uint256 finalAmount;
        uint256 initialAmount;
    }
    uint8 index;
    bool flag1;
    address admin;
    bool flag2;
    bool flag3;
    uint256 public number;
    mapping(address => uint256) balances;
    address admin2;
    payments[8] topPayments;

    constructor() {}

    function setNumber(uint256 newNumber) public {
        number = newNumber;
    }

    function increment() public {
        number++;
    }
}
