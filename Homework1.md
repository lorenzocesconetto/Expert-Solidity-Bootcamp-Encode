# Homework 1 - Blockchain

By: Lorenzo Cano Cesconetto

## 1. Why is client diversity important for Ethereum

Having multiple and independent clients, i.e., diversity, makes the network more resilient to attacks and bugs.

Notice that having multiple clients available is not enough, these clients must be adopted in a way that the active nodes are roughly evenly distributed across them.

Ideally, no consensus client would ever reach a 33% share of the total nodes.

-   **Bugs**: If there are multiple clients (>2), each client alone will always be a minority. If there's a bug in an individual client, it is likely that other nodes do not share the exact same bug. Therefore the buggy transactions will not be accepted consensually.

-   **Attacks**: For example, an attack that tricks a particular client onto a particular branch of the chain is unlikely to be successful because other clients are unlikely to be exploitable in the same way and the canonical chain remains uncorrupted. Low client diversity increases the risk associated with a hack on the dominant client. Client diversity has already proven to be an important defense against malicious attacks on the network, for example the Shanghai denial-of-service attack in 2016 was possible because attackers were able to trick the dominant client (Geth) into executing a slow disk i/o operation tens of thousands of times per block. Because alternative clients were also online which did not share the vulnerability, Ethereum was able to resist the attack and continue to operate while the vulnerability in Geth was fixed.

-   **Proof-of-stake finality**: A bug in a consensus client with over 33% of the Ethereum nodes could prevent the Beacon Chain from finalizing, meaning users could not trust that transactions would not be reverted or changed at some point. This would be very problematic for many of the apps built on top of Ethereum, particularly DeFi. Worse still, a critical bug in a client with a two-thirds majority could cause the chain to incorrectly split and finalize, leading to a large set of validators getting stuck on an invalid chain. If they want to rejoin the correct chain, these validators face slashing or a slow and expensive voluntary withdrawal and reactivation. The magnitude of a slashing scales with the number of culpable nodes with a two-thirds majority slashed maximally (32 ETH).

Source: [Ethereum Foundation](https://ethereum.org/en/developers/docs/nodes-and-clients/client-diversity/), visited on May 1st of 2023.

---

## 2. Where is the full Ethereum state held?

The full Ethereum state is **NOT** stored on the blockchain.

The protocol assumes that the client implements the state as a mapping in a modified Merkle Patricia tree, which is stored on disk and is calculated rather than received via consensus communication (except when the node is first joining the network).

Though, each block does store the **hash of the state trie root**. In other words, Keccak 256-bit hash of the root node of the state trie after all transactions are executed. This hash is used to confirm that nodes have the current accepted state.

This system allows a node, to "synchronize" with the blockchain extremely quickly without processing any historical transactions. The node may simply download the rest of the tree of the latest block from nodes in the network, and verify that the tree is correct by checking that all of the hashes match up, and then proceeding from there.

The account state, comprises the following four fields:

-   **nonce**: A scalar value equal to the number of transactions sent from this address or, in the case of accounts with associated code, the number of contract creations made by this account.
-   **balance**: A scalar value equal to the number of Wei owned by this address.
-   **storageRoot**: A 256-bit hash of the root node of a Merkle Patricia tree that encodes the storage contents of the account (a mapping between 256-bit integer values), encoded into the trie as a mapping from the Keccak 256-bit hash of the 256-bit integer keys to the RLP-encoded 256-bit integer values.
-   **codeHash**: This is empty for EOA. The hash of the EVM code of this account—this is the code that gets executed should this address receive a message call; it is immutable and thus, unlike all other fields, cannot be changed after construction.

Source: [Medium Blog Post](https://medium.com/@eiki1212/ethereum-state-trie-architecture-explained-a30237009d4e), visited on May 1st of 2023.

Source: [Ethereum Blog](https://blog.ethereum.org/2015/06/26/state-tree-pruning), visited on May 1st of 2023.

---

## 3. What is a replay attack? Which 2 pieces of information can prevent it?

In a replay attack the attacker uses a previously signed transaction and is able to trick the blockchain into executing the transaction again.

The two pieces of information that prevent it are `v` and `nonce`.

-   `nonce`: Protects against within blockchain replay attacks. The `nonce` is a transaction counter, which assures that even if two transactions are identical, because the `nonce` is different, the signature will be different.

-   `v`: It represents the blockchain id, and is encoded in the transaction signature as well. It protects against cross chain replay attacks. Since many EVM blockchains share the same public and private keys, an attacker could replay a transaction by grabbing a signature from one blockchain and submiting to another. But `v` guarantees that these signatures are not actually cross chain compatible.

---

## 4. In a contract, how do we know who called a view function?

View functions do **NOT** write to the state of the blockchain, it is restricted to only reading on-chain state information.

Therefore, if the view function was called within a transaction, then the `msg.sender` will be the address who called it (not necessarily the EOA that initialized the transaction).

On the other hand, if the view function is being called within a simple call, then Ethereum will not require an associated transaction sender. So the variable `msg.sender` defaults to the zero address, but it could be any address because signatures are not verified in simple calls.
