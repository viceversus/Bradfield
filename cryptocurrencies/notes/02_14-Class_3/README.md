# Types of Encryption
## Asymmetric Cryptography
* There are 2 keys - Pub and Pvt
* Public key is meant to be shared, private key is meant to be private
* You can encrypt and decrypt with either.
* If you encyrpt something with private/public key, you can only decrypt with same key.
* Can be used to create Digital Signatures

## Symmetric Cryptography
* AES, DES
* There is 1 secret key, and you want to make sure that secret key is safe. Both people need a copy of this key.

# Asymmetric Cryptography
## Digital Signatures
1. Must be easy to verify given public keys
2. Only the private key can create a signature (unforgeability)
3. You can tie the signature to a piece of data. You cannot remove the signature from the data.
4. Unrevokable
5. You want to prove that you in fact own that data.

## Methods for Asymmetric Cryptography
* `generate_keys()` => `(pvt_key, pub_key)`
  * Need to generate an effective source of randomness
* `sign(msg, pvt_key)`
* `verify(signature, msg, pub_key)` => bool
* hash(msg) before signing in order to speed up

## Trapdoor Functions
* Integer Factoring
  * Take 2 primes (31, 46) -> Multiply them together -> Finding those original primes from the product is super hard
* Discrete Logarithm problem with Integer Factoring is what produces RSA
* ECDSA - Elliptic Curve Digital Signature Algorithm

## RSA
* Used to be 256 bits, now recommended 2048 bits

## ECDSA
* Standard keysize 256 bits
* For the same amount for 228 bit RSA key, amt of energy to decrypt is boiling a teaspoon of water. For ECDSA, boil all of the water on earth.

## Quantum Computing
* All public crypto systems will be decrypted by quantum computing, and back in time.
* Shor's Algorithm - will allow quantum computing to decrypt everything.

# Bitcoin
## Keys
* Public key is your identity
* Private key is the key to your wallet
* You can make as many identities as you want
* SSL on Github is just an RSA key. Each keypair is tied to your identity, which is your GH username
* In Bitcoin, public key **is** your identity.

## Address
* `Ripemd160(pub_key)` is your Address
* Why?
  * Ripemd160 is shorter
  * Hashing is not breakable by quantum Computing

# Cryptographic Hash Functions
## Properties of Hashing Functions
* Fixed output size
* Uniform
* Deterministic

## Encoding
* A way transforming data from 1 form into a different Uniform
* Base64, Raw13... Not designed to be difficult to reverse

## Encryption
* Obfuscated using some kind of secret key... another key can be used to decrypt
* Used to hide things

## Hashing
* Irreversable
* Used to hide
* Intrinsically lose data

## Cryptographic Hashing Functions
* Collision-resistant
  * You'll never create the same hash from 2 different pieces of data
  * All outputs are unique (impossible)
* Difficult to reverse
* Puzzle-friendly
  * Highly Sensitive
  * Avalanching
  * VERY NEARBY plain text should result in VERY DIFFERENT results
  * "Hello" and "Hellp" should be completely different after hashing.

## Attacks when you have collisions
* How hard is it to generate **any** collision
* For 2^256
  * Naive solution: 2^256
    * 2^256 === 2^256
  * Birthday attack: 2^128
    * Keep generating keys storing all the other keys
  * Preimage attack: 2^256
    * Given a digest -> plain text
    * Unhide the text
  * Second Preimage attack: 2^256
    * Given a preimage, find a collision

## MD5 Hashing Function
* 128 bits
* Birthday attack 2^24

## MD4 Hashing Function
* Generate collisions in 2 operations by hand

## SHA-1
* 128 bits
* 2^90 collision

## SHA
* Bitcoin uses SHA-2 (and lots of other crypto)
* Secure Hash Algorithm - designed by NIST
  * SHA-0 - quickly broken
  * SHA-1/SHA-2 - Used for a while, designed by NSA
  * SHA-3 - Not designed by NSA

## Merkle-Damgard
* Narrow pipe construction
* Vulnerable to length extension attack

# Cryptography in Cryptocurrency
## Hashcash
* Uses cryptographic hashing function for Proof of Work.
* Make sending email arbitrarily costly.
* I give you a string "hi"
  * You append a number and hash it
  * SHA("hi" || 00001) -> hf294...
  * The game is to find an output with 3 leading 0's
  * once you find a solution, you can use that as a token
* SHA("email@email.com" | timestamp | Nonce)

## Bitcoin
* Uses the idea for proof of work

# Merkle Trees
Used in Git, every Cryptocurrency

## Bittorrent
* You can see hash of entire file
* Allows you to prove the integrity of the file
* If it does not match the hash, you have something that is not correct or corrupted
* Using Merkle tree, you can find which block went wrong in `log(n)` time

## Proof of Inclusion
* Takes `log(n)` time.
* Merkle proof is logarithmic in time and complexity

## Bitcoin
* Used to store all the transactions in the block
* All the transactions are referenced by a Merkle root
* The block is a MB of data. Block headers are small

## Vulnerability
* There's a naive attack you can do with the same Merkle root
* Cut the tree in half
* Including the height of the Merkle tree gets rid of that problem
