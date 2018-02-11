# P2P network
## What is a P2P network
* A group of nodes that share data with each other rather than through a central server

## Decentralization
* There is no single source of truth
* There isn't a single point of failure
* Why is this important?
  * Censorship resistant
    * Nobody can take it down because they don't like it
  * Fault tolerance
    * When one or several notes go offline, it can still operate
    * Degrees of fault tolerance - correlated to redundancy

## Gossip Protocol
* A bunch of nodes reaching consensus about state is *not* a good use case for gossip Protocol
* Gossip protocol is good when you want *very high* fault tolerance
  * Bitcoin is a good use case. Everybody stores everything and needs everything.
* In most cases, messages don't need to reach everybody
* Floods bandwidth with messages.
* Some distributed databases (CassandraDB), everybody needs to know about everybody else.

## Weaknesses
* anonymity
  * Hard to maintain anonymity
  * If you're talking to the centralized server, you can encrypt before sending to the centralized server
  * In a P2P, you can trace data through the nodes that are speaking to each other.
* efficiency
  * high network load
* network effects
  * how do you get past the bootstrapping phase
* difficult to maintain quality control
  * stop spammers or bad actors

## Why did they fall out of favor?
* hard to reward good actors
* industries cracking down on them
* more complexity
  * how do you upgrade?

# History of P2P
## First file sharing networks
* First networks had a ton of churn
* People are leaving all the time and you have to account for that

## Folding@home and SETI@home
* Once you're not using the computer, it starts to do work on protein folding or computations.

## Reputation
* P2P networks and protocols started to be associated with piracy
  * Public P2P networks fell out of favor
* People started to figure out better, more scalable centralized systems

Easier to change and monetize the system when it's centralized.

# Napster
Founded by Sean Fanning and Sean Parker. Napster was fanning's nickname in college because he liked to take naps.

## Topology
* Centralized
* Napster had a hash table that knew who has which files.
  * Tuples of <filename, ip, portnum>
* No intelligent de-duping or consolidation
* You connect directly to the peer
* Entirely over TCP
* Only sharing of music files

## History
* 80 Million Users
* High speed networks in college dorms
  * As much as 60% of traffic
* Metallica, Dr Dre, and ANM/RIAA sue'd them
* Led to the birth of golden age of file sharing protocols

## Problems
* Low anonymity
  * You could query Napster and get anybody's IP
  * Everything in plain text
* Central point of failure
  * All nodes connected to a central server
* Single source of congestion
  * Nobody can use efficiently if Napster gets backlogged
  * Resource locations is super fast through
* Napster was responsible for users copyright infringement
  * Indirect infringement - aiding and abetting
* They stopped 99.4%, but judge said it wasn't good enough
  * They shut down, and were acquired by Rhapsody

Napster was replaced by Gnutella and Kazaa.

# Gnutella
## Topology
* Overlay network. There is no Gnutella server anywhere, just "servents".
  * Nodes may be connected over the internet, but may not be connected through the Gnutella overlay
* Periodically PING to see if somebody is online
* 5 messages
  * `Query` - 'oops-i-...'
    * TTL - prevents zombie messages that circulate forever
      * C^TTL - how many nodes you'll reach
      * C = Avg # of connections
      * TTL = Time to live
    * UUID - You don't want to send duplicate requests. You'll most likely receive the same message that you sent
    * IP - Where do you send your QueryHit
    * Payload - Filename
  * `QueryHit`
    * 'I have that file'.
    * not point to point.
    * travels back through the query line. nodes can cache using...
    * tree traversal - everybody knows where they got their message from because their messages are cached. path finds back to original node
  * `Ping`
  * `Pong`
  * `Push`
* You search for "oops_i_did_it_again"
  * Your message flood are your peers for the file... they flood all their peers... and so on.
    * Message propagates by UDP.
  * TTL decrements on every blast.
  * Node has the file, then it sends a `QueryHit` responsible
  * Then you send a `Push` to that node which means "I want to download"
* Downloads via HTTP

## Firewalls
* NAT hole-punching

## Problems
* 50% of network traffic was just `Ping` and `Pong`
  * Started concatenating `Ping` messages
* 70% of users were free-riding
  * You can intelligently decide what you share and what you don't.
* Flooding
  * A lot of excessive traffic

UDP
* Send a packet and forget.
* Best effort

TCP
* SYN - ACK - SYNACK
* has some guarantee of packet transfer

# Gossip protocol
## Multicasting
  * Unicast
    * point to point
  * Multicast
    * sending messages to multiple people, but not everybody
  * Broadcast - message to everybody
    * Cable, Radio, WiFi

## Ways to do Multicast
  * Take the set of nodes and do a for-loop
    * Linear
    * You need to know all the recipients
      * You have to commit to the network topology
  * Randomly decide N peers to send message to
    * Recursive
    * With random propagation, all nodes will eventually receive message

## Push vs Pull model
  * Push you a messages
  * Pull based model
    * lowers congestion
    * Periodically query my peers about what the latest gossip is

## Problems
  * Infections spread very quickly
  * Depends on number of edges
  * Network load is very high
    * Messages are logarithmic, but not really
    * Amount of bandwidth that gets used is exponential

## Properties
  * Very high reliability
  * Low latency
  * Light weight
  * Fault tolerant
    * Even with 50% packet loss, just 2x number of rounds.
    * Same with 50% node failure, just 2x number of messages

## Use cases
  * Sensor networks and wireless networks
  * Share information about network topology
  * Distributed databases (CassandraDB)
  * Cryptocurrency

## How do you get in the network as a new node
  * Have to connect with a seed node.
  * Centralized
  * DNS is not safe or encrypted
    * Very easy to Man in the Middle

## Spanning Tree protocol (alternative)
* A tree that has no cycles.
* It is the minimal number of branches to connect to each node.
* Only 1 path to each node
* Ideally it is a minimum spanning tree
* Spanning tree protocols are optimal, given a fixed network topology

### Problems
* Not fault tolerant
  * If a node goes offline, you have to reconfigure all nodes.
* In practice, you need other messages to get passed
  * It scales linearly vs logarithmically
