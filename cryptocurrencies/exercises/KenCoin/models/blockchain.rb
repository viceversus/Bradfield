require 'Digest'

module KenCoin
  class Blockchain
    BLOCK_REWARD = 100
    attr_reader :blocks

    def initialize()
      @blocks = []
    end

    def add_block(transaction)
      add_genesis_block(transaction) if @blocks.empty?

      return unless sufficient_balance?(transaction) && transaction.is_valid?

      previous_block = @blocks[@blocks.length - 1]
      previous_hash = ''
      previous_hash = ::Digest::SHA2.hexdigest("#{previous_block.previous_hash}#{previous_block.nonce}") if @blocks.length > 1
      @blocks << Block.new(transaction, previous_hash)
    end

    private
    def add_genesis_block(transaction)
      genesis_block = Transaction.new('', transaction.from, BLOCK_REWARD, '')
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
