// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

contract Homework6 {
    function returnEth() public payable returns (uint) {
        assembly {
            return(0x00, 32)
        }
    }
}
