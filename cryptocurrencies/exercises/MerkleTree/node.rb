require 'Digest'
require 'byebug'

module MerkleTree
  class Node
    attr_reader :header, :value, :left, :right

    def initialize(header, val=nil, left=nil, right=nil)
      @header = header
      @value = val
      @left = left
      @right = right
    end

    def is_leaf?
      @left == nil && @right == nil
    end

    def generate_proof(header, proof = [])
      return if is_leaf?

      children = [@left.header, @right.header]
      if children.include? header
        proof += children
      else
        children_proofs = [@left.generate_proof(header, proof), @right.generate_proof(header, proof)].flatten.compact
        unless children_proofs.empty?
          children_proofs + children
        end
      end
    end

    class << self
      def create_from(data)
        nodes = []
        nodeify_data(data).each_slice(2) do |node_pair|
          add_padding(node_pair)
          header = Digest::SHA2.hexdigest("#{node_pair[0].header}||#{node_pair[1].header}")
          nodes << Node.new(header, nil, node_pair[0], node_pair[1])
        end

        nodes.length > 1 ? create_from(nodes) : nodes[0]
      end

      def verify_inclusion(block, proof, root)
        return false unless proof.include?(block) && proof.length > 1
        index = proof.find_index(block)
        next_hash = if index == 0
          Digest::SHA2.hexdigest("#{block}||#{proof[1]}")
        else
          Digest::SHA2.hexdigest("#{proof[0]}||#{block}")
        end

        return true if next_hash == root
        verify_inclusion(next_hash, proof[2..-1], root)
      end

      private
      def add_padding(node_pair)
        if node_pair.length == 1
          node_pair[0].is_leaf? ? node_pair.push(Node.new('')) : node_pair.push(node_pair[0])
        end
      end

      def nodeify_data(data)
        data.map do |datum|
          if datum.is_a?(MerkleTree::Node)
            datum
          else
            Node.new(Digest::SHA2.hexdigest(datum), datum)
          end
        end
      end
    end
  end
end
