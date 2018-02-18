require 'Digest'

module MerkleTree
  class Node
    attr_reader :value, :left, :right

    def initialize(val, left=nil, right=nil)
      @value = val
      @left = left
      @right = right
    end

    def is_leaf?
      @left == nil && @right == nil
    end

    class << self
      def create_from(data)
        nodes = []
        nodeify_data(data).each_slice(2) do |node_pair|
          add_padding(node_pair)
          string_pair = "#{value_from(node_pair[0])}||#{value_from(node_pair[1])}"
          val = Digest::SHA2.hexdigest(string_pair)
          nodes << Node.new(val, node_pair[0], node_pair[1])
        end

        nodes.length > 1 ? create_from(nodes) : nodes[0]
      end

      private
      def value_from(node)
        node.is_leaf? ? Digest::SHA2.hexdigest(node.value) : node.value
      end

      def add_padding(node_pair)
        if node_pair.length == 1
          node_pair[0].is_leaf? ? node_pair.push(node_pair[0]) : node_pair.push(Node.new(''))
        end
      end

      def nodeify_data(data)
        data.map { |datum| datum.is_a?(MerkleTree::Node) ? datum : Node.new(datum) }
      end
    end
  end
end
