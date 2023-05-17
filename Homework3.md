# Homework 3 - EVM Deep Dive

By: Lorenzo Cano Cesconetto

---

## 1. What are the advantages and disadvantages of the 256 bit word length in the EVM?

---

-   **Advantages:**

    -   The 32 bytes (256 bits) word allows Keccak-256 hashing algorithm to run efficiently.
    -   It also facilitates Elliptic curve computations.

-   **Disadvantages:**
    -   There's a major waste of resources when we're dealing with numbers considerably smaller than 2^256, which happens very often.
    -   It impacts both memory usage, as well as processing power when computing operations such as sum, div, iszero, etc.

---

## 2. What would happen if the implementation of a precompiled contract varied between Ethereum clients?

---

The different clients would not come to a consensus and the network would end up with forks.
