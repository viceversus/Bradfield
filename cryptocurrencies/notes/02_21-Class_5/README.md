# Economics in Cryptocurrency

The fact that we are creating things that have value in the real world, we can use the properties of the system to enforce incentives that we want to be desirable.

## Economics in Bitcoin
* Miners listen to transactions
* Try to compute a PoW function
* If they successfully compute a block, they gossip
* If they get a bigger blockchain, they cancel, then they try to do it all over again

## Security Model of Bitcoin
* The assumption, is, if more than 50% of the notes are honest, then the nodes are probabilistically secure.
* You can have a 51% attack. Make a transaction, go back, out mine the main chain with faulty chain where you did not make that transaction.
* You cannot spend somebody else's coins.

## Block-size
* Number of transactions is judged by block-size parameter specific to each cryptocurrency.

# Mining
## Kinds of Bitcoin Users
* Light Clients
* Full Nodes
  * Only 10k full nodes that can be publicly seen
  * You don't have to be a full node to mine.

## Mining Setup
* Have a bunch of mining machine and 1 full node.
* Mining machines will try to solve the puzzle, and full node will do the gossip.

## Unspent Transaction Outputs (UTXO) Model
* Account based Model
  * State of cryptocurrency is determined by some hashmap with accounts and balances
* UTXO - Instead of accounts, you have unspent transaction outputs
  * Genesis transaction. Sends Satoshi a UTXO of 3000 BTC.
  * Satoshi then sends money to Hal Finney. 100 BTC.
  * That UTXO is now dead.
  * 1 UTXO gets sent to Hal Finney, 100 BTC. The remaining 2900 BTC gets sent **back** to Satoshi
* Why?
  * You only have to keep track of the tips of the graph.
  * Set of unspent transactions can be smaller than the total account space
* If you have a bunch of tiny UTXOs, it'll cost more money to do a Tx than if you had 1 large UTXO
* Dust limit
  * If moving the UTXO costs the transaction fee, then that UTXO essentially just dies
  * Consolidation will cost more or equal to just leaving it.


## Mempool
* UTXOs consolidated and put into the mempool.
* Each miner sees most of the currently transmitted transaction, and use that figure out what to include.
* Miners choose blocks based on fees. Allows price discrimination.
*  [Bitcoin Mempool](https://blockchain.info/unconfirmed-transactions)

## Price Discrimination
* I can pay more for higher service.
* I can pay more money to have my bitcoin Tx mined faster

## Mining Rewards
* If you send a transaction, you can leave some unspecified.
* Whoever mines that block gets the unspecified leftovers
* There's also a coinbase reward

## Coinbase Transaction
* Every block contains a coinbase transaction
* Block reward
* Coinbase transaction is given to that block address.
* Started as 50 BTC.
  * Every 210k blocks, it halves.
  * We're currently at 12.5 BTC

## Bitcoin Supply
* 80% of all bitcoin already exists
* By 2040, all BTC will be minted
* 21,000,000 is the total supply
* By 2025, we'll be close to 99% of all BTC mined

# Mining Pools
## Why?
* Mining is **extremely** hard now. A lot of hashes per second are being mined.
* If you are running a CPU, it'll take hundreds of years to mine a block. Unlikely you'll mine anything in the lifetime of the hardware.
* Even with optimized hardware, every couple years maybe?

## What?
* In order to have a steadier income stream, they band together into mining pools.
* Pool hashing power together, and everybody gets paid out.

## How?
* You mine a block difficulty that's 1/256th of the reward.
* You get a share for '0000' instead of '00000000'
  * Pool keeps track of all the shares
* If somebody actually mines the block, how do you make sure that person sends it to everybody?
  * The coinbase transaction is pointed to the pool operator.
* Vast majority of the time you just get shares.
* The pool can also fuck you over, but they're skimming a little of the top so not much incentive.

## Bad Actors
* Pools can act like cartels
* Pools could start double-spending
* This is intrinsically discouraged. The price would tank if some pool had 50%

# How does mining work
## Bitcoin uses SHA256
* SHA2 is a CPU hard algorithm
* It was originally run in C, but it turns out you can do way better

## GPU Mining
* GPU is way faster at doing SHA2 than CPU
* 1/10 the cost, and way more efficient
* Made CPU mining not profitable
* GPU costs have been rising

## Field Programmable Gate Array (FPGA)
* Program it to do Bitcoin hashing over and over again

## ASIC
* Application specific integrated circuit
* Circuit that just mines SHA256 hashes

This is a multi-billion dollar industry now.

## Electricity Consumption
* Amount of energy is more than the entire country of Ecuador on a per day basis.

## ASIC-Resistant Hashing Algorithm
* SCrypt - Memory Hard Algorithm
  * 2 Gigs of memory to unroll
  * Simple function to aggregate the data once it's unrolled
  * Memory (RAM) is as fast as it's going to get and it's already commoditized.
  * GPU has you covered for memory hard algorithm (which is why GPUs are so expensive now)

# Security
Secure assuming that good nodes have more than 50% hashing power.

## Hashing Power
* How does this correspond to nodes?
  * It doesn't. The language of BFT doesn't cover the complexity of Bitcoin.
* You want good nodes to join to get more hashing power.
* Why does good hashing power come in? Because they are getting paid.
* If bitcoin was not a currency, this wouldn't work.
* I'll pay you to secure my network. If it's secure, then the money I give you will be worth something.

## Bootstrapping Problem
* Every cryptocurrency has this bootstrapping problem.
* Tools of DS has no concept of incentives.
  * You can't pay somebody to not be Byzantine... that's not part of the model.

## "All security is economic security."
* We're making a claim about computational hardness
* Implicitly, this is a claim about economic hardness
* What is the difference between 2^32, 2^64, 2^256?
  * Why is 2^256 secure and not 2^32, and why is 2^64 in the middle?
  * It's because of how much it would cost to crack the algorithm. It's an economic argument.
  * 2^128 would cost millions of dollars. Nobody's password is worth that much.
    * What if it's a nuclear server though? Maybe it is worth that money now
* Secure at its base, means that it's expensive.
* If security is economic, you can pay people to do the right thing. You can punish people to do the wrong thing.

# Crypto-Economics
Combination of game-theory, and economics to create security.

# Game Theory
* Study of mathematical models of conflict and cooperation between rational decision-makers.
* Payoff Matrix
  * A way of analyzing how rewards are paid out.

## Chicken - Payoff Matrix
```
              B - Stupid      B - Forfeit
A - Stupid    -5 / -5          2 / -2

A - Forfeit   -2 / 2           0 / 0
```
* Independent choice theory
  * If B is stupid, I should forfeit
  * If B forfeits, I should be stupid
* This is a negative sum game

## Prisoner's Dilemma - Payoff Matrix
* 2 prisoners in jail
* If you rat, we'll give you a lighter sentence
* If you don't and they do, you get a worse punishment.

```
              B - Coop      B - Snitch
A - Coop      -1 / -1          -7 / 0

A - Snitch    0 / -7           -4 / -4
```

* If they both coordinate, it's the best outcome.
* If B cooperates, I should snitch. 0 > -1
* If B snitches, I should snitch. -4 > -7
* If I'm a rational actor, I'll always snitch.

## Prisoner's Dilemma in Practice
* Tragedy of the Commons
  * Farmers with cattle grazing
* How do you avoid?
  * Reward good behavior
  * Punish bad behavior

## Nash Equilibrium (Bottom right in Prisoner's Dilemma)
* A point on the Payoff Matrix where neither have an incentive to change their strategy.
* No player is ever going to move. Everybody's incentive is to stay in that place.

## Revolutions - Multiple Nash Equilibria
* You're in the middle of a revolution. If you are fighting the monarchy, you're fucked if you get caught.

```
              Society - Civil      Society - Revolt
You - Civil         2 / 2               -2 / 1

You - Revolt       -5 / 0                5 / 5
```

* Nash equilibria here is either Civil/Civil or Revolt/Revolt.
* If you're in 1 of the Nash Equilibrium. It's very hard to move away from this stable situation.
* Coordination Problem - Everybody is Civil, but the King sucks. You can't move towards an everybody Revolt situation.
  * How do you trust that somebody will revolt with you if that's what they tell you?
  * If you found a 3rd party that you both trusted, you can have a contract that will allow for a large negative payout if you go back on your word.

## Schelling Points
* You in 1 person from this experiment are going to meet in NYC. You won't know who it is.
* The only way you know who the other person is, is via a secret password that you both know.
* A lot of people would end up finding each other. How?
  * Focal points that people gravitate to.
  * I will go to Grand Central Station and yell out my password.
  * I will go to Statue of Liberty at Noon and yell out my password.
* You are going to get executed unless you pick the same number as another inmate on death row in the next room.
  * You have a 1/8 chance.
  * But what if the numbers looked like this
  `23 14 480 90 38 100 387 82 33`
  * Then people win most of the time because they pick 100

## Tit for Tat
* Cooperate until defect
* If they defect, then defect.
* If they cooperate again, then cooperate.

You can use `Smart Contracts` to change payoffs in your matrix.

# Schelling Coin
* I want to put a bunch of data on the blockchain. But I don't want to centralize where this data is coming from.

## Oracle
* When you want a data feed, that provides data.
* It can be centralized... or it can be decentralized.

## Participation
* Each player locks up 5 BTC to participate in this scheme.
* They report to the blockchain what they said the weather was.
  * A => 69, B => 67, C => 99, D => 68, E => 69
* Sort all these
  * C => 99, A => 69, E => 69, D => 68, B => 67
  * First and last get removed.
  * A, E, and D get rewarded 3.33 BTC
  * C and B get nothing.

## Rewards
* You should try to be honest as you'll likely get cut out or you own't lose rewards.
* Nash Equilibria is everybody tells the truth or everybody lies.
  * Incentive is todo what everybody else is doing.
  * However, it's extremely hard to Coordination Problem.

## Vulnerability
* A bad actor, bets a large amount of money that it's 0 degrees in LA
* I want everybody to agree with me
* I approach each player with trying to lie
  * I'll construct a new payoff matrix for you.

  ```
                Everyone Else - Truth      Everyone Else - Collude
  User - Truth              3.3                         -10

  User - Collude            -10                         3.3
  ```
* If you lose because everybody colluded with me, I'll pay you an extra 10. If you collude, I'll pay you a little more.

  ```
                Everyone Else - Truth      Everyone Else - Collude
  User - Truth              3.3                         -10

  User - Collude            3.3                         3.3
  ```

* No incentive now to tell the truth.
* Bad Actor actually pays nothing.
* Bad Actor needs to have collateral of 13.3.

## Why wouldn't get 51% and double spend on Bitcoin?
* It would destroy the value of the currency.
* You'd invalidate your own investment.

# Feather forking
* Say you want to censor some group of people - People J - how do you do it?

## Punitive Forking
* If you have 51%, you can do punitive forkings.
* No people J!
* If somebody else mines a block with People J transactions, you'll mine a block at the same height. And invalidate that block.
* Everybody is now incentivized to not include blocks from People J

## Feather Forking
* How can you censor with only 20% hashing power
* No People J in my block.
* Somebody else mines block, with People J.
* You mine a block with no People J at the same height.
  * Nobody will mine on this chain.
  * I have to mine a 2nd block to win the race.
* If I have 20%, I have a 1/5 * 1/5 chance of winning this race.
  * If I lose the 2nd block, I give up
* If people realize that the person is doing this
  * Now that block is only 96% guaranteed.
  * Other people will move over to the discriminatory block because they will have 100% guarantee.

## Selfish Mining
