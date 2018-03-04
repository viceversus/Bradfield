# Ethereum Background
## Bitcoin Script
* Basically sucks.
* Stack based programming language.
  *  You can push items onto the stack and then push operators onto the stack, and that's it.
* Bitcoin programming is not fun and it's not powerful
* Not turing complete
* Limited op codes
* Miners will reject most scripts, preventing general innovation.
* Operation runs once every 10 minutes.
* Inputs(pubkey, signature) -> Txn -> Output(amount, script)
  * Every output includes a script. If somebody provides the output that fulfills this script, they can use this UTXO
  * The things that are fed into the Input are the args that would fulfill the Output
* P2PKH - Pay 2 Public Key Hash
  * Script includes hash of Pubkey. Must provide the preimage to this cache. Prove that you have the private key that matches the pubkey.
  * The person that is claiming the UTXO is needs to feed that output script the correct information.
* There are fairly complex things you can do with Bitcoin script. It's just really expensive.
  * Bitcoin lottery.
  * You can't do it effectively because of the weakness of Bitcoin Script

## Altcoins
* A category and a pejorative
* Originally just a fork of bitcoin that messed with parameters.
* Litecoin, Dogecoin etc.
  * Litecoin used Scrypt to be memoryhard
  * Segwit originally used in Litecoin
  * Breeding ground for things that might get eventually included in Bitcoin

## Mastercoin
* Bitcoin was let's allow people to exchange bitcoin as currency. That's it.
* The ability to create user deploy user defined currencies on top of Mastercoin.
  * On-chain publishable price feeds - publishing data
  * On-chain betting on the price feed
* Added new primitives
* Add applications specific OP_CODES to Bitcoin.
  * Adding special bespoke functions to bitcoin script

## Vitalik Buterin
* Student from Toronto and early Bitcoin aficionado
* Founded Bitcoin magazine (and Ethereum)
* Had a meeting with the Mastercoin team and had a bunch of ideas for them.
  * Proposed for Mastercoin to complete a turing complete programming language
  * Mastercoin team was too busy to do that.
* Organized ideas into a whitepaper and recruited people the help him build this.
  * Gavin Wood
  * Andrew Miller
  * Open source consortium started to build up
* Completely reimagine what the role of a blockchain could be in a cryptocurrency.

## Ethereum
* Bitcoin - Decentralized ledger for payments
* Ethereum - Use blockchain to create a decentralized computer to compute smart contracts
  * Smart Contracts are just the programs that run on this decentralized computer
* In total, with all the ICOs and DApps, it's bigger than bitcoin

## Smart Contracts
* Big blockchain thing - you can transfer **value** over the internet. Not just information.
  * Smart Contract is an extension of that concept.
  * Programs that are run on the blockchain and can transfer value based on rules.
* In the real world, if you don't follow the contract, you break the rules, you have to go sue or use the law or people with guns enforce these contracts.
* With smart contracts, we don't need people with guns to do this.
  * Self enforcing contracts.
  * All you need is code.
* If the ledger is the money, you don't need men with guns and lawyers to enforce the money transfers
* "Code is law."

# Ethereum
## Accounts
* Everybody has an account.
* That account points to a balance.
* 2 Kinds of Accounts
  * Externally Owned Account - User
  * Contracts
    * Can have money
    * Can send transactions
    * First class citizens
    * Able to spend and own money

## Smart Contracts
* Smart Contracts can only do anything if somebody pokes them.
* Contract is Hash and keep hashing the string.
  * Smart contract must get poked by a user initiate the action for the contract to perform that action.

## Transactions
* Only EOAs can send transactions
* Contract Invocation
  * I want to call this contract and this address
  * With whatever bytecode
  * That contract will execute
* Contract Deployment
  * I want to deploy this contract at this address with this ABI
* Ether Transfer - send money to X

# Solidity
* Turing complete smart contract language

## Turing Completeness
* A turing complete language is a general programming language
* A turing complete language can simulate any Turing Machine
  * Turing machine was a tape that can have 1's and 0's on it with a HEAD
  * Based on instructions on the tape, it will either move right, left, delete something, overwrite something...
  * Based on this, it can perform any arbitrary computation
* Any program written in any Turing Complete language can **also** be written in any other Turing Complete language
* Is turing complete: Python, Ruby, JS, SQL
* Is not turing complete: Regex
* Need loops and recursion
  * Bitcoin has no loops or recursion

## Negatives against Solidity
* Unbounded loops - Halting Problem
* Difficult to estimate costs
* Complexity is the enemy of security
* Formal verification is much harder
  * Formal verification - in no possible execution if this program will this program go rogue or be in a bad state

## Halting Problem
* It is impossible in general given a Turing complete language, to prove that a program halts.
* If the state space is large enough
* Most languages dramatically bound the state space.
  * In general, languages minimizes the amount of branching and and state space.
* We cannot compute if a program will infinitely loop.

## Busy Beaver - Difficult to estimate costs
* It would require you to solve the halting problem.
* Figuring out how many operations a program of length N can perform - Busy Beaver Function
* Busy Beaver
  * Uncomputable
  * Grows faster than any other function

# Gas Model
* Makes Ethereum not Turing complete
* You cannot run a while loop.

## Gas
* The currency that you can use to pay miners.
* A separate currency from ether.
* Each computational step requires some amount of Gas to be paid.
* You give an amount of gas with computation. Miners will run your program with that gas.

## Simple computation - 5 + 3
* push 5 <- 3 gas
* push 3 <- 3 gas
* ADD <- 5 gas
* Gas assigns cost to each of those operations. Each opcode has a cost.

## Infinite loop with Gas Model
* Miner runs loop until they run all the computations until there is no more Gas. Then it reverts state and the person who requested the infinite loop doesn't get the gas back.
* If the program completes, sender gets the remaining Gas back.

## Ether to Gas
* You only own ether, not gas.
* If you want to send a transfer, when you call that method, you tell the miner that I'm willing to pay .00001 ETH per Gas
* Gas Limit - Max gas I'm willing to pay is 3000 Gas
* Ether that you're willing to pay per gas is your transaction fee.
* Miners only care about Gas Price. Price per unit of computation
* Ethereum has no blocksize limit. They have a Gas Limit per block.
  * Miners can vote over blocksize limit

## Ethereum is not Gas
* Allows you to have a parameterizeable fee
* It wants to decouple those things
* You cannot hold gas.

# Ethereum Virtual Machine
  * 256 Bits
  * Stack based
  * OP_CODE Gas costs can only be changed by Hard Forks
  * Gives you access to the blockchain state.
    * Prev blockhashes
    * Timestamp
    * Blockheight
  * Precompiles - Hand coded special OP_CODES
    * ECDSA, hashing, etc.

## Solidity
  * Most popular high level language on the EVM
  * Combination between C and Javascript
  * Invented by Gavin Wood

## Viper
  * More auditable
  * More recent programming language
  * Not production ready yet. Created by Vitalik
  * No overflows or underflows
  * No inheritance
  * No unbounded loops

# Ethereum Mining
## Mining Algorithm
* Homegrown algorithm called - Dagger Hashimoto
  * Based on Dashimoto
* Memory hard - ASIC resistant
  * but not memory hard to verify
* Keccak 256 - Not exactly SHA3
  * Hashing Function for all other things not PoW

## Ethereum Accounts  
* Balance - 256 bits
  * Smallest Unit is called a Wei.
    * Finney, Szabos, GWei.
  * Gas is usually measured in Gwei
* Address - Keccak(ECDSA pubkey)[0..160]
* Nonce: 0
  * Number of transactions that you have done
  * Ensure ordering
  * Stop replay attacks

## Mining
* Look at mempool, sort by Gas
* Execute the transactions that you want
  * In a block header, there are 3 Merkle roots
    1. State Tree
      * Stores every account
    2. Txns Tree
      * Same as bitcoin
    3. Receipts Tree
      * Where logs go
      * Smart contract execution and can get queried efficiently
* Execute your transaction.
  * Creates a new state root because it changes accounts
* Dagger_Hashimoto(All 3 of those Merkle Roots)
  * Number of 0's etc etc.

## Why is nonce important?
* In Eth, operations are not communative.
  * With UTXOs, it doesn't matter what order I execute them in unless we use the **same input**
* The order in which I execute 2 functions really matters in Eth.
  * As a miner, I am free to reorder transactions however I want and affect output state.
* Rational miners will always take highest gas fee.
  * If a miner decides they can profit more by arbitrarily ordering transactions
  * If an ICO is happening, and the network is congested, they can put their own transactions in before other higher Gas Price.
    * Observed in the status ICO - Transaction Injection
* Protects against miner shenanigans

## Miners
* Can arbitrarily inject Transactions
* Reorder transactions
* Front-running

## Replay Attack and Malicious Reordering
* Joe -> Sally 5 ETH
* You can just replay this transaction again if you want
* Each transaction you send must have a nonce of 0. Then 1. Then 2.
* Miners cannot reorder your transactions

# DAO
## Decentralized Autonomous Organization
* Company that exists as a smart contract
* You can have shareholders or not.
* You can pay out salaries
* It can call other contracts.
* Used for decentralized governance.

## The DAO
* Venture capital pool
* A bunch of people got ether together.
* 220M Ether. 7% of Ether on blockchain
* People could pitch the DAO, and those pitches would be evaluated by a board selected by DAO shareholders.
* Hacked in 2016 and dissolved

## What did ETH enable?
* Escrow contract
* Casinos
* Predictions market
  * Do you think thing X or Y will happen?
* Decentralized Exchanges
* Cryptokitties

# GHOST protocol
* Greedy heavily observed state trees.
* Uncle blocks are rewarded
  * If you include rewards for uncle blocks, it increases the security of the protocol
  * Fundamentally, what secures the network is hashing power, so you can afford a faster block-time if you have some rewards for uncle blocks.

# Computation Price on Ethereum
* Everything is extremely expensive
* Calcualating a checkmate would take $10M

# ICO
* Initial Coin Offering
* Ways to crowdfund new Cryptocurrency
* You can build ICOs on top of Ethereum.
* ERC-20
  * Just an interface that all ERC-20 compliant tokens implement
  * Transfer, Transfer-From, Allow, etc
  * Triggered a lot of innovation and mania around ETH
* Largest ICO is FileCoin - $252M
* EOS - over $1B in contracts
