# Homework 5 - Assembly 1

By: Lorenzo Cano Cesconetto

---

## 1. Look at the example of init code in today's notes (see [gist](https://gist.github.com/extropyCoder/4243c0f90e6a6e97006a31f5b9265b94)). When we do the CODECOPY operation, what are we overwriting?

---

We are overwriting the free memory pointer at `0x40`.

---

## 2. Could the answer to Q1 allow an optimisation?

---

Yes! The constructor just sets a storage slot to 17. It does NOT need the memory at all. So the free memory pointer wasn't needed, and some gas could be saved by not setting it.

--- 

## 3. Can you trigger a revert in the init code in Remix?

---

Yes, the contract uses the `CALLVALUE` opcode and then checks if it's zero with `ISZERO` opcode. If it's not zero, we won't jump at the `JUMPI`, therefore we'll hit the `REVERT` opcode. So we can trigger it simply by sending any value to the constructor upon deployment.

---
## 4.1 Write some Yul to add 0x07 to 0x08 then store the result at the next free memory location.

---

```
function add_7_8() public pure returns(uint256) {
    let sum := add(7, 8)
    let freePtr := mload(0x40)
    mstore(freePtr, sum)
    mstore(0x40, add(freePtr, 0x20))
    return(freePtr, 0x20)
}
```

Updating the free memory pointer would not be necessary in this case because the function returns without handling the control back to solidity. But since this is generally a good practice, I've included in the code.

---
## 4.2 Write this again in opcodes

---

```
PUSH1 0x07
PUSH1 0x08
ADD
PUSH1 0x40
MLOAD
SWAP1
DUP2
MSTORE
DUP1
PUSH1 0x20
ADD
PUSH1 0x40
MSTORE
PUSH1 0x20
SWAP1
RETURN
```


---
## 5. Can you think of a situation where the opcode EXTCODECOPY is used?

---

Delegate calls will copy the third-party code and execute within the original contract context.

---
## 6. Complete the assembly exercises in this [repo](https://github.com/ExtropyIO/ExpertSolidityBootcamp)
