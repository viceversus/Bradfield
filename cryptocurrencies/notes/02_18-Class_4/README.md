# Consensus
* Def: Agree on a value and we do not change our minds. It is set in the blockchain.
* We agree on one value at a time and we **never** revert.
* Consensus is easy if everybody is online and honest (assuming no faults and honest participants)
  * Have a single leader and everybody follows them
  * Majority rules

## Fault or Fail-Stop
* A node goes offline by instantly dying. Fail-stop.
* Stops communication completely

## Fault-tolerant Consensus
* This is hard, non-trivial
* Follower A - Leader - Follower B
  * What happens if Leader goes offline?
  * Maybe Follower A just takes its place until leader gets online.
  * What happens if **then** Leader comes back online and Follower A doesn't know yet.
  * What if Follower A thinks Leader is offline but Leader still has a connection with Follower B?
* Split Brain - breaks Consensus
  * Some systems will not promote a leader and just shut down
  * This is the worst possible case. Your data is not reliable

## Paxos
* First fault tolerant consensus algorithm proven to be correct
* Complicated, notoriously opaque of why it is correct
* Can tolerate a high number of faults
* Modeled consensus as state machine replication
  * Leader is a state machine, follower all replicate that state
* Somebody needs to get elected as the Leader
  * Then everybody listens to the Leader
  * When the leader fails, host another election.
  * Make sure that everybody agrees on the new leader before moving forward
* Chubby, Spanner, Neo4J - all use Paxos internally
* Raft created as a simple
  * Simple
  * Zookeeper uses a Raft/Paxos hybrid

## Fault tolerance limitations
* A fault tolerant system can only handle up to 49.9% faults
  * If 6/11 nodes have a write command, if less than 50% nodes go offline, theoretically you can still deliver the write to the rest of the nodes
  * If more than 50% go offline, there's a chance that all 6 nodes that received the write are down, and then you cannot move forward.

# Byzantine Fault (Byzantine Generals Problem)
* Leslie Lamport
* A node fails by sending arbitrary messages
  * A malicious node
  * A node sending garbage data
* Extremely difficult if nodes are extremely malicious as possible
* A good model of a public payments model
* Bitcoin is BFT
* Bittorrent is not BFT

## Story
* Army from Byzantium
  * They want to attack a village.
  * For the attack to be successful, all the generals have to attack at the same time or all need to retreat at the same time.
* Can the generals achieve consensus in the presence of a Byzantine fault?
  * The Byzantine fault is a traitorous general

## 2 general scenario - Impossible
* General A and General B
* General A -> I'll attack if you attack
* General B -> If you receive this, I'll attack
* General A -> OK, I got it. Please attack.
* This goes on forever. You cannot end this cycle.

## 3 nodes - Impossible
* Commander and 2 Lieutenants
* Lieutenant gets Attack from Commander, but Retreat from L2
* Commander is evil, L2 is being honest
  * Or it could be L2 is lying to L1
* Nobody in the system including commander, can tell who is lying

## 4 nodes - Smallest number of nodes to overcome 1 Byzantine node
* Commander is Byzantine
* L1 <- Attack, L2 <- Attack, L3 <- Retreat
  * Everybody can tell that L1/L2 are honest
  * Majority rules
  * Remove Commander
* Doesn't matter **who** is Byzantine. It just matters that we achieve consensus.

## BFT limitations
* `(Faulty Nodes) t < 1/3 N`
* In order to achieve consensus in spite of a faulty node

## Properties
* Non-triviality
  * Value that you reached is a value to somebody proposed
  * Agree on a value that somebody proposed, not some random value
* Safety
  * At **most** 1 value is agreed upon
  * We actually achieve consensus
  * Not eventually consistent
* Liveness
  * Given that some value is still being proposed, the system will eventually agree to a next value
  * Does not stop making progress

## Byzantine Paxos
* Emphasize safety over liveness
* They **never** equivocate
* They'll stop making progress if there are too many faults
* Too slow

## Using Cryptography
* You can solve Byzantine fault tolerance by using Cryptography
* You can always tell what the commander's message is

## Practical Byzantine Fault Tolerance (PBFT)
* PBFT
* Quadratic # of messages
* Paxos and Raft - 10k txs/s
* PBFT - 1000s tx/s and does not scale well
* Less than 1/3 nodes
* All of the nodes must be known in advance (Byzantine Paxos, Paxos, Raft, PBFT)
  * Need to know how big the electorate is
  * Otherwise you don't know if you are `t < 1/3n`
* Sacrifices liveness for Safety

## Where is BFT used?
* Aeronautics
  * What happens if one of your gauges go down. Other 3 should keep working
* Space travel
  * Flying through cosmic rays, radiation, etc.
* Public network with randos

## Why is PBFT not good for Bitcoin
* You need to know N
* The network topography is consistently changing

# Bitcoin and Byzantine Fault Tolerance

* Knowing that Bitcoin is full of malicious nodes

## What will they lie about
  * They cannot lie about payments
  * They cannot lie about who is sending who
  * Because of public key crypto. Assuming asymmetric cryptography work.
  * Double Spend

## Ordering - Problems
  * What came first?
  * However, in DS, there is no concept of ordering. There is no global time.
  * Clock synchronization is really hard.
    * Clocks tick at different rates. How your clock diverges from central timekeeper.
    * Your clock will drift over time. It may even change over time.
  * Clock synchronization protocols - Network Time Protocol (NTP)
    * Who cares about "real time", we just need our clocks to be close to each other
    * only thing you can do in DS
  * Nodes will equivocate on what happened first

## Ordering - How to Agree
* Who spoke first? Commander or L2
* We could use consensus
* In the case of Byzantine Faults, if people lie, it breaks the system
* Using cryptography to solve the problem
  * Unscalable to sign every message you see then broadcast
* Need a way to prove sequentiality
  * Easy way is to have a centralized time-stamping server
  * How do you replace a centralized time-stamping server with a decentralized time-stamping server? This is how to unlock a decentralized currency.


## 1991 - Habern and Stornetta - Linked Timestamping
* Take each document, hash it
* That hash is rolled into the next hash
* N1 = H(D1)
* N2 = H(prev, H(D2))
* This creates an unrevokable series of timestamps
* Ensures that the previous hash existed before the next hash because it was used to produce the next hash
* In order to fake this, you need to produce a hash collision

## Blockchain - Satoshi's solution
* When I want to create a new transaction, I have to append it to the chain of blocks
* Transaction
  * Pointer to the a hash of the previous block
  * Signature
* This is enough to force an ordering - but not enough to solve the Problems
* Go back in time, and create a forked chain that's longer than the original chain where I spent coins
  * It's too hard for us to achieve consensus when it's too easy to create bullshit blocks

## Proof of Work
* Verifiable time delay functions
* You have to add a nonce to the block that will have it start with 0000
* Makes it expensive to produce new blocks
* Makes it very expensive to extend the chain in another direction
* A new block get created every 10 minutes
* Blocks are produced very slowly. Easy to detect when blocks are inching forward
* Ability to produce ordering of blocks is proportional to your computational power in the network.

## Assumptions
* Computer power will be evenly distributed.
  * In big P2P network, the power of all the collective honest nodes will be too great for a bad actor to compete with

## Bitcoin Blockchain
* A chain of messages where each block points to a hash of its previous block
* Each block has a nonce, where that nonce combined with the previous hash contains some number of leading 0s
* This blockchain **forces an ordering** on all transactions


# Nakamoto Consensus
## aka Fork Choice Rule (aka Longest fork rule)
* You are a node getting blockchains from a bunch of people
* Rules
  1. Once you hear about a blockchain of height H, you reject any blockchain where H2 < H.  
  2. Any blockchain where H2 = H, I will ignore
  3. If H2 > H, then I move to H2. Synchronize to every blockchain that is greatest length

* Most likely most of the nodes will agree on what blockchain is longest
  * All the good nodes are building on Chain A with block A,B,C
  * All trying to vie for creating Block D
    * Have a majority of computing power

* If an attacker tries to create a block B' to create a double spend
  * They'll have to create a block B' and C' to catch up to the good chain.
  * They don't have enough computing power to catch up to the main chain.

* Even if attacker tries and creates block C',
other good actors won't inherit bc of Nakamoto consensus.
  * In order to be a bad actor, you have to beat the rest of the good actors **twice**

* In Nakamoto consensus, so long as you're less than half, you can most likely beat the bad actors.
  * Sometimes, the bad actors will win. Very small probabilistic guarantee

* What if a tie happens
  * Block C and Block C' get mined at the same time.
  * Ties are rare, but reasonably common
  * In all likely hood, 1 of the transactions, D or D' will win out and one of the tie forks will die
  * Orphan block
  * 6 blocks is usually good enough for confirmation

* Bitcoin and Nakamoto Consensus has **no finality**
  * probability that it reaches 0 is very small
  * If somebody developed a quantum computer, they could overwrite the history of the blockchain

## Nakamoto vs PBFT
* Higher threshold for Byzantine
* Prioritizes Liveness over Safety
  * A fork is a violation of safety
* No sense of fixed validators
* Nodes can come and leave
* PBFT does not scale
* Nakamoto performance characteristics don't change with the number of nodes
* PBFT can be very fast (1000tx/s) with small number of transactions
* Nakamoto consensus is slow even with a small number of nodes
* PBFT gives absoulte finality, Nakamoto goes probabilistic (or actually no) finality


# Cryptocurency
* Digital Identities via public key crypto
  * Transactions are signed by the sender - Authentication and avoid Byzantine generals problem
* Transactions are from pub key -> pub key
* Uses a blockchain to force and ordering of transactions
  * Add Proof of Work to make forks costly
* Gossip protocol for networking
* Fork-choice rule or Nakamoto Consensus for distributed BFT consensus
