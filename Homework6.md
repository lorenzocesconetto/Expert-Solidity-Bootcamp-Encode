# Homework 6 - Assembly 2

By: Lorenzo Cano Cesconetto

## 1. Create a Solidity contract with one function. The solidity function should return the amount of ETH that was passed to it, and the function body should be written in assembly


Solution is at [Homework6.sol file](./Homework6.sol)

---

## 2. Do you know what this code is doing?

This contract is cloning itself into two other contracts. It sends `callvalue` Wei to the first contract upon creation, and then sends the remaing Wei upon self destruction to the second contract.
The created contracts are identical to the original one.

Now let's understand step by step:

1. The original code is a `runtime code` with 0x1e = 30 bytes.
2. This code stores in memory itself preceded by 9 bytes which is the `creation code`.
3. This `new composed code` will be sized in total 0x27 = 39 bytes which is just the 30 + 9 bytes.
4. Using this `new composed code` in memory, the original contract creates two new contracts.
5. These new contracts will execute the 9 bytes from `creation code` which basically gathers the `runtime code` and returns it, making the new contracts identical to the original one.

If you want to understand these 9 bytes from the `creation code`, here's a walk through:
```
60 PUSH1 0x1e # This is the size of the run time code
80 DUP1
60 PUSH1 0x09 # We'll skip the initial 9 bytes when code copying
3d RETURNDATASIZE # pushes zero to the top of the stack
39 CODECOPY # copy to position zero at memory 0x1e bytes skipping the first 9 bytes from memory
3d RETURNDATASIZE # pushes zero to the top of the stack
f3 RETURN # return the run time code which is at 0 -> 0x1e in memory
```

---

## 3. Explain what the following code is doing in the Yul ERC20 contract

```
function allowanceStorageOffset(account, spender) -> offset {
    offset := accountToStorageOffset(account)
    mstore(0, offset)
    mstore(0x20, spender)
    offset := keccak256(0, 0x40)
}
```
This code implements a `mapping` data structure.
It returns an address from storage where the value of the allowance from `account` to `spender` is stored.
Whoever calls this function may pass the return value to `sload` in order to obtain the allowance value.

Each account has a unique `offset`.

The `key` of the mapping is obtained by hashing (with `keccak256`) the `account offset` and the `spender` address.
