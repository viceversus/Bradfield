require_relative '../services/proof_of_work_service'
require_relative './transaction'

module KenCoin
  class Block
    attr_reader :content, :previous_hash, :nonce, :hash

    def self.json_parse(json_string)
      json = JSON.parse(json_string)
      transaction = Transaction.json_parse(json['content'])
      Block.new(transaction, json['previous_hash'])
    end

    def initialize(content, previous_hash, worker=ProofOfWorkService)
      @content = content
      @previous_hash = previous_hash
      @worker = worker
      @nonce = calculate_nonce
    end

    def calculate_nonce
      @worker.mint(@previous_hash, 4)
    end

    def to_json(opts={})
      {
        content: @content.to_json(opts),
        previous_hash: @previous_hash,
        nonce: @nonce
      }.to_json
    end
  end
end
