# Homework 7 - Functions

By: Lorenzo Cesconetto

## 1. The parameter X represents a function. Complete the function signature so that X is a standard ERC20 transfer function (other than the visibility). The query function should revert if the ERC20 function returns false.

The ERC20 standard interface maybe found [here](https://docs.openzeppelin.com/contracts/2.x/api/token/erc20#ERC20-transfer-address-uint256-):
```
transfer(address recipient, uint256 amount) → bool
```

Following this interface we get:
```
function query(uint _amount, address _receiver, function(address,uint256) external returns(bool) X) public {}
```


---

## 2. The following function checks function details passed in the data parameter.
```
function checkCall(bytes calldata data) external {}
```

## The data parameter is bytes encoded representing the following 
### - Function selector
### - Target address
### - Amount (uint256)

## Complete the function body as follows: The function should revert if the function is not an ERC20 transfer function. Otherwise extract the address and amount from the data variable and emit an event with those details `event transferOccurred(address,uint256);`.


The ERC20 transfer function sinature is `transfer(address,uint256)`

We can obtain the hash of the sigture with the followint snippet: `web3.utils.sha3("transfer(address,uint256)`

Which returns: `0xa9059cbb2ab09eb219583f4a59a5d0623ade346d962bcd4e46b11da047c9049b`

Grabbing the first 4 bytes: `0xa9059cbb`. Therefore the selector must match this value.

```
function checkCall(bytes calldata data) external {
    bytes4 selector = bytes4(data);
    require(selector == 0xa9059cbb); // Revert if not ERC20 transfer signature
    (address target, uint256 amount) = abi.decode(data[4:], (address,uint256));
    emit transferOccurred(target, amount);
}
```

