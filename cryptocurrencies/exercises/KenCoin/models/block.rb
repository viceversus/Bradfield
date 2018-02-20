require_relative '../services/ProofOfWorkService'

module KenCoin
  class Block
    attr_reader :content, :previous_hash, :nonce, :hash

    def initialize(content, previous_hash, worker=ProofOfWorkService.new)
      @content = content
      @previous_hash = previous_hash
      @worker = worker
      @nonce = calculate_nonce
    end

    def calculate_nonce
      @worker.mint(@previous_hash, 4)
    end
  end
end
