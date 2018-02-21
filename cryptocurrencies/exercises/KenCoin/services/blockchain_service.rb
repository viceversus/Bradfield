require_relative '../models/blockchain'
require_relative '../models/transaction'

module KenCoin
  module BlockchainService
    extend self
    def initialize_blockchain
      @current_blockchain = Blockchain.new
    end

    def current_blockchain
      @current_blockchain
    end

    def choose_blockchain(our_blockchain, other_blockchain)
      if our_blockchain.blocks.length < other_blockchain.blocks.length
        @current_blockchain = other_blockchain
      end
    end

    def generate_transaction(pkey, recipient, amount)
      transaction = Transaction.new(pkey.public_key, recipient, amount)
      transaction.sign(pkey)
      @current_blockchain.add_block(transaction)
    end

    def blockchain_from_json(json)
      Blockchain.json_parse(json)
    end
  end
end
