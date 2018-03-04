# Solidity
* Everything is raw bytes
* Weird types
* Address

## Smart Contracts
* They only do things once you poke them
* They are immutable - cannot change
* If you want to redeploy the code, you have to deploy a new contract to a new address

## Remix
* Anytime you send a transaction that mutates state, it creates a new block.
* You can set it up to talk to a local Geth node.

## Assignment
* Simple gambling game
* 2 distinct players
* Bet 1 eth
* 1 player randomly wins and is rewarded 2 ether -  transaction fees

## Randomness in Blockchain
* You cannot rand in blockchain.
* Everything must be deterministic.

## Commit reveal
* Cryptographic commitment
* I'll secretly commit to a value before showing you what the real value is.
* Commitment - H(msg)
  * Reveal message later by hashing the pre-image
* Use a nonce
  * nonce + msg
* Commit to a minimum #.
  * 2^64 is minimum. hash that.

## Player 2 attack by nonaction
* Player 2 can never reveal after Player 1 succeed.
  * You can pay player 2 a little bit of money to reveal. Make EV slightly greater than 0.
  * Wait some number of blocks. If they don't , player 1 wins.

## Another attack based on adding
* There is a property of adding. To always ensure that number is even.
* If I add the exact same number I can always get an even number.
* Prefix with 1 or 2
* Don't allow identical pre-images

## Randomness
* Oracle
  * Trusted 3rd party
  * Oraclize
    * Query random.org and publish it on the blockchain for a small fee
  * RanDAO
    * decentralized organization - multiparty computation

* Pseudorandomness
  * Comes from the blockchain itself.
  * Exploitable
  * Miner Address - You can try to control of the address by taking control of the block.
  * Timestamp - have no idea that you're lying about your timestamp
    * This value is totally manipulable to the miner.
    * You can bribe the miners.
  * Block hash should be evenly distributed, so you can maybe use it
    * Cannot complete the pre-image
    * Miner might throw away a block after they mine it - if it's not the one they want.
    * This randomness will be the same for every transaction for that block
    * You don't have access to the current blockhash
    * You only have blockhash(n-1).
    * Wait until blockhash(n). Waiting period until we collect the blockhash.
