require 'Digest'

require_relative './block'

module KenCoin
  class Blockchain
    BLOCK_REWARD = 100
    attr_reader :blocks

    def self.json_parse(json)
      blocks = json.map do |json_block|
        Block.json_parse(json_block)
      end

      Blockchain.new(blocks)
    end

    def initialize(blocks=[])
      @blocks = blocks
    end

    def add_block(transaction)
      add_genesis_block(transaction) if @blocks.empty?

      return unless sufficient_balance?(transaction) && transaction.is_valid?

      previous_block = @blocks[-2]
      previous_hash = ''
      previous_hash = ::Digest::SHA2.hexdigest("#{previous_block.previous_hash}#{previous_block.nonce}") if @blocks.length > 1
      @blocks << Block.new(transaction, previous_hash)
    end

    def valid?
      @blocks.map.with_index do |block, i|
        i == 0 || !@blocks[i+1] ? true : validate_block(block, @blocks[i+1])
      end.all?
    end

    def to_json(opts={})
      @blocks.map { |block| block.to_json(opts) }.to_json
    end

    private
    def validate_block(current_block, next_block)
      ::Digest::SHA2.hexdigest("#{current_block.previous_hash}#{current_block.nonce}") == next_block.previous_hash
    end

    def add_genesis_block(transaction)
      genesis_block = Transaction.new('', transaction.from, BLOCK_REWARD)
      @blocks << Block.new(genesis_block, '')
    end

    def sufficient_balance?(transaction)
      transaction_map = Hash.new(0)
      @blocks.each do |block|
        t = block.content

        transaction_map[t.from.export] -= t.amount if t.from != ''
        transaction_map[t.to.export] += t.amount
      end

      transaction.amount <= transaction_map[transaction.from.export]
    end
  end
end
