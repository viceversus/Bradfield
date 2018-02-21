module KenCoin
  module ConsensusService
    extend self

    def choose_blockchain(our_blockchain, other_blockchain)
      if our_blockchain.blocks.length >= other_blockchain.blocks.length
        our_blockchain
      else
        other_blockchain
      end
    end
  end
end
