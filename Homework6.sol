// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

contract Homework6 {
    function returnEth() public payable returns (uint) {
        assembly {
            mstore(0x00, callvalue())
            return(0x0, 0x20)
        }
    }
}
