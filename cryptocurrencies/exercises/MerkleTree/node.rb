require 'Digest'

module MerkleTree
  class Node
    attr_reader :value, :left, :right

    def initialize(val, left, right)
      @value = val
      @left = left
      @right = right
    end

    def self.create_from(data)
      nodes = []
      data.push '' if data.length.odd?
      data.each_slice(2) do |node_pair|
        string_pair = "#{value_from(node_pair[0])}||#{value_from(node_pair[1])}"
        val = Digest::SHA2.hexdigest(string_pair)
        nodes << Node.new(val, node_pair[0], node_pair[1])
      end

      nodes.length > 1 ? create_from(nodes) : nodes[0]
    end

    private
    def self.value_from(node)
      if node.respond_to? :value
        node.value
      else
        Digest::SHA2.hexdigest(node)
      end
    end
  end
end
