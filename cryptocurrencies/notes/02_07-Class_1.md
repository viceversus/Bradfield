# Intro
## Office Hours
Thursday - Some 2 hour block TBD

## What is money?
1. Unit of account
  * You can denominate value
2. Medium of exchange
  * We can use it as cash
3. Store of value

## How did money begin?
### Started with barter economies
  * Based on current needs
  * Based on double coincidence of wants - you have to have a perfect match. Person has thing X and wants thing Y and needs to find a person who wants thing X and has thing Y.
  * Commodity money - the things you trade in a barter economy.

### Credit
  * allows you to denominate debts

### Cash
  * I'll give you some material good that you can pay for some other material good
  * 1200 B.C. - cowry (?) shells used in China
  * 1000 B.C. - First use of metals for cash (China)
  * 600 B.C. - Gold coins
  * 1000 A.D. - Song dynasty: Paper money, first Fiat currency
  * 1300 A.D. - Marco Polo paper money in EUR
  * 1400 A.D. - First modern bank, Italy
  * 1661 A.D. - Bank Notes invented in Sweden
    * 19th Century - Central Bank still fairly weak
    * No consolidation of bank notes until Civil War
  * 1816 A.D. - Britain pegs currency to Gold
    * 1900 - America joins gold standard
  * 1944 Bretton Woods - monetary management rules about all the exchange rates
    * Everybody had to have gold reserves and issue currency backed by gold.
    * All currencies convertible to each other because all were convertible by gold.
  * 1971 - Nixon breaks away from Gold Standard and breaks Brenton Woods
    * Allowed central bank to dictate money
    * Could we have avoided the Great Depression if we had this then?
  * 1950 - First Credit card
    * 80's Credit Cards were ubiquitous
  * 2002 - Paypal valued at 2.2B
    * 2009 - Bitcoin goes live
    * 2010 - First bitcoin pizza
    * 2015 - Ethereum
    * 2017 - BTC 300B Market Cap

### Why metal?
* Durable
  * Hard to corrode
* Scarce
  * Low inflation
* Hard to fake
* Arbitrarily divisible

### Fiat currency
* A currency without intrinsic value
* Money is valuable because people said so
* It has value because of consensus, not because of collateral
* Central banks can affect its value (hyperinflation)

### Why is the US Dollar still valuable?
* Anybody can pay their taxes using it
* People are willing to take it

## Money on the Internet
### First, Credit Cards
* In the early days of the internet, there's a lot of skepticism about giving your credit card info to a merchant
* No https... all info available to view

### FirstVirtual
* How does it work?
  * User -> Pizza Store - I want Pizza
  * Pizza store -> FirstVirtual - User wants Pizza
  * FV -> User - yes/no/fraud
  * if yes, FV has User's CC info, charges CC
* Merchant does not receive payment for 90 days
* Everybody has to be enrolled in the system

### CyberCash
* Had institutional backing
* SET
  * User encrypts Merchant so only the bank can read it
  * Merchant gets the encrypted block and forwards it on to the bank.
  * Merchant will also send their encrypted payload.
  * If the bank sees they match, its good
* Digital identities in the form of certs
* Had to sign up and get issued a digital cert and prove identity.
* Nobody wanted this - because certs were a pain in the ass

### Paypal
* Came at the right time
* Had a use case (ebay)

## Cash-based Internet economy
### Cryptography
* Before 70's, arcane mathematics
* Most of the advancements were in military and government
* Cryptography was considered military arms until 1999
  * Total monopoly by government

### David Chalm
  * Building the first digital currency
  * "Security without Identification, Transaction to make Big Brother obsolete"
  * Wanted to use cryptography to try to break the monopoly of the state for the issuance of currencies

### Cypherpunks
* Started in 1992, 1994 700k subscribers
* 1995 Cypherpunks manifesto
  * Online privacy of communications.
  * Respect rights of pseudonyms
  * Up to citizens to check power of government
  * Resistance of censorship and monitoring
  * Hiding the act of hiding - hiding should not be considered an act of malfeasance
* Adam Bach - Posted a 3 line RSA algorithm that people should use to sign their email
* Julian Assange, PGP creators, Signal creators, Torr creators were all cypherpunks
* Relying on the US government was bad because they could ultimately become tyrannical, and it was unsafe
* TNO - trust no one

### Mojo Nation
* First ideas of digital Cash
* Users allocated "mojo"
* You can spend coins to download, and if you seeded files you receive coins.
* Solved a lot of the problems of bit-torrent - freeloader problem
* Created an economy - where it paid to be altruistic

### Hashcash
* Adam Bach
* Anti-spam solution - problem back then
* You have to solve some computational puzzle. Solving the puzzle will serve the email otherwise, you don't get it.
* Good users will be willing to spend the CPU cycles
* It will be too costly for spammers
* Discussed as a potential currency

### ECash (Digicash)
* David Chalm
* First serious digital cash system
* Specific coins. Coins were not divisible.
* Blind signatures allowed users to stay anonymous when making purchases, but the bank could still validate spends
* Users purchasing things were anonymous, but merchants were not
* The coins themselves were unique.
* No story for user/user payments

### EGold
* 1996
* Currency that was issued by EGold
* Collateralized by gold
* Denominated by a certain amount of Gold
* Cost more than 2B in spends a year
* Shut down for legal and regulatory reasons
* Ponzi schemes, hacking, fraud
* First currency for Ransomware
* Made an example of
* Once EGold was shutdown, money went away

### Is there away to build digital cash without collateral?
* How can you create cash that still valuable?
* Has to have some guarantee on scarcity
* Has to be useful

### Double Spend Problem
* What's stopping somebody from copy/pasting a digital currency.
* You won't know until you redeem it.

### Denationalization of Money
* Hayek
* Why should nations have a monopoly on money
* Issuance of Fiat money has always been controlled by nation-states

### Financial Crisis in Modern Times
* 1999 Dotcom
* 2008 Financial Crisis
  * Delinquent banking
* Centralized banking is inherently tyrannical because of inflation
  * Seigniorage - printing money to finance yourself
  * By printing money, they are devaluing everybody's money. This is a form of taxation.
  * Cypherpunks thought government had too much power.

### bmoney (Wei Dai) and BitGold (Nick Szabo)
* Non-Collateralized
* Proof of Work - for minting new coins
* Timestamping - trusted server
* Didn't have a good consensus model
  * Counted votes. Vulnerable to Sybil attack
* Only described in blog posts. Nobody shipped them.

### Sybil attack
* Creating several accounts to gain a consensus in a vote counting model

### Satoshi
* August 2008 - Satoshi Nakamoto - Posted a whitepaper for bitcoin
* Hal Finny and Wei Dai
* As far as we can tell, May 2007 is when he started coding.
* Later in Aug 2008, he released the code for bitcoin.
* Stuck around for 2 years
* Dec 2010 - Satoshi left the project
* No proof that anybody is satoshi.
* The bitcoin that satoshi initially mined is still sitting in the wallet.
* Not familiar with David Chalm's work with ecash
* Probably not an academic
* Cites Hashcash, bmoney, bitgold, reusable PoW,
* When he wrote Wikipedia...
  * Implementation of bmoney and bitgold.
  * Probably British
* Last time anybody heard from Satoshi is 2010
