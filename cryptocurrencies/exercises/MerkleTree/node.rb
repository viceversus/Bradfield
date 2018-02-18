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
      puts nodes
      data.each_slice(2) do |node_pair|
        string_pair = "#{value_from(node_pair[0])}||#{value_from(node_pair[1])}"
        val = Digest::SHA2.hexdigest(string_pair)
        nodes << Node.new(val, value_from(node_pair[0]), value_from(node_pair[1]))
      end

      if nodes.length > 1
        create_from(nodes)
      else
        nodes[0]
      end
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
