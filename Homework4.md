# Homework 4

By: Lorenzo Cano Cesconetto

---

# Optimising Storage

## 1. Take [this contract](https://gist.github.com/extropyCoder/6e9b5d5497b8ead54590e72382cdca24). Use the sol2uml tool to find out how many storage slots it is using. By re ordering the variables, can you reduce the number of storage slots needed?

---

We can generate a storage layout visualization by running the following command:

```
sol2uml storage -c <contract name> <sol file path>
```

In this case:

```
sol2uml storage -c Store ./Homework4.sol
```

See the [original storage layout](./Homework4-initial-storage.svg) and then the [optimized storage layout](./Homework4-optimized-storage.svg) obtained by reordering the state variables.

The updated contract source code may be found [here](./Homework4.sol)

---

# Foundry Introduction

1. The following command creates a new `Foundry` project from this [template](https://github.com/PaulRBerg/foundry-template):

    ```
    forge init homework4 --template https://github.com/PaulRBerg/foundry-template
    ```
1. If you don't have `pnpm` installed:
    ```
    npm install --global pnpm
    ```
1. And then finally install the dependencies:
    ```
    pnpm install
    ```

--- 
## Is this valid solidity?

--- 
Yes, it is. As we can see in the [solidity documentation](https://docs.soliditylang.org/en/latest/types.html#function-types), functions are indeed a type and a first class citizen. Therefore functions can be passed as parameters to other functions, as well as being returned by them.

A simpler use case to visualize the syntax of this would be:

```
contract MyCon {
    function a(function() external pure) external pure {}
}
```
Here you can see that the function `a` takes a function as its only argument.

We can keep nesting functions in `MyCon` until we have the exact code that this questions refers to. Therefore, the code is perfectly valid.
