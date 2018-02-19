# Putting it all together: your first cryptocurrency

It's time now to build our first cryptocurrency!

Naturally this is going to be a toy cryptocurrency and we're going to be cutting some corners. But our goal is to have a network of full nodes that are achieving consensus on the same blockchain.

Here are the recommended steps:

1. First, build out your blockchain from the blockchain assignment.
2. You'll want to adapt this blockchain to store transactions rather than random strings. I recommend creating a `Transaction` class, which includes a `from` (public key), `to` (public key), `amount` (int), and `signature` (string). Have each block contain one transaction for simplicity.
3. Make your blockchain validate that all of the transactions within the blockchain are valid—i.e., each transaction does not put any party into a negative balance. You'll want to start all blockchains with a genesis block that gives someone seed money to begin the chain.
4. Implement a fork choice rule. Given your current blockchain and a new blockchain, write a function that replaces the old blockchain with a new blockchain if it's longer than your current blockchain (and valid!)
5. Go back to your gossip protocol and adapt it to gossip blockchains rather than random messages. You may want to use a good marshalling library for your language to make it easier to serialize and deserialize your objects. Apply the fork choice rule to any message you receive.
6. Give each node a public key and private key. Give it an endpoint so that another node can query it for its public key.
7. Give each node a `transfer` endpoint, which will make it query another node for its public key, and then transfer that node some of its money.
8. See the blockchain in action!

That said, feel free to approach this in whatever way you feel makes the most sense.
