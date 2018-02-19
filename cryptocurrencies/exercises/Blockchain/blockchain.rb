require 'Digest'
require_relative '../ProofOfWork/proof_of_work'
require_relative './block'
require 'byebug'

module Crypto
  class Blockchain
    attr_reader :blocks

    def initialize(data)
      @blocks = []
      data.each_with_index do |content, i|
        previous_block = @blocks[i - 1]
        previous_hash = ''
        previous_hash = ::Digest::SHA2.hexdigest("#{previous_block.previous_hash}#{previous_block.nonce}") if i > 0
        @blocks << Block.new(content, previous_hash)
      end
    end

    def add_block(content)
      previous_hash = ::Digest::SHA2.hexdigest("#{@blocks[@blocks.length - 1].previous_hash}#{@blocks[@blocks.legnth - 1].nonce}")
      @blocks << Block.new(content, previous_hash)
    end
  end
end
