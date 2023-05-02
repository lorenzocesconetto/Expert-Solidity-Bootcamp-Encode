// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.17;

contract Homework2 {
    uint[] public array;

    constructor() {
        array = [2, 3, 4, 5, 6]; // Initial example
    }

    // Easily set a new example without redeploying the contract
    function setArrayToRange(uint n) public {
        uint[] memory newArray = new uint[](n);
        for (uint i = 0; i < n; ++i) {
            newArray[i] = i;
        }
        array = newArray;
    }

    function getArray() public view returns (uint[] memory) {
        return array;
    }

    function _isIn(
        uint _value,
        uint[] calldata _array
    ) internal pure returns (bool) {
        for (uint i; i < _array.length; ++i) {
            if (_array[i] == _value) {
                return true;
            }
        }
        return false;
    }

    // If the order doesn't need to be preserved,
    // and we're deleting just one item at a time
    function deleteAtIndex(uint _index) public {
        require(array.length > _index, "Invalid index or array is empty");
        array[_index] = array[array.length - 1];
        array.pop();
    }

    // If we're deleting multiple items simultaneously and preserving order
    function deleteItems(uint[] calldata items) public {
        // Since we don't need to modify "items", let's keep it in calldata
        // unchecked: There's no possibility of underflow or overflow within this code
        unchecked {
            require(array.length >= items.length);
            uint[] memory newArray = new uint[](array.length - items.length);
            uint j;
            uint currValue;

            for (uint i = 0; i < array.length; ++i) {
                // Since we only loop through the storage state once,
                // there's no need to copy it to memory
                currValue = array[i];
                if (!_isIn(currValue, items)) {
                    newArray[j] = currValue;
                    ++j;
                }
                // For each value in "items" that is not found in "array",
                // an element will be sliced in the end of it by stopping the iteration early
                // This is also valid for repeated values in "items"
                if (j == newArray.length) break;
            }
            array = newArray;
        }
    }
}
