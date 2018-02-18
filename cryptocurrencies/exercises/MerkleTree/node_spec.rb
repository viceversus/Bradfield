require 'rspec'
require './node'

describe MerkleTree::Node do
  describe '.create_from' do
    it "returns the correct hash" do
      data = %w(We hold these truths to be self-evident that)
      root = MerkleTree::Node.create_from(data)
      expect(root.value).to eq "4a359c93d6b6c9beaa3fe8d8e68935aa5b5081bd2603549af88dee298fbfdd0a"
    end

    it "creates hash when there are odd numbers of words" do
      data = %w(We hold these truths to be self-evident)
      expect { MerkleTree::Node.create_from(data) }.to_not raise_error
    end

    it "uses a different padding strategy for internal and leaf nodes" do
      data = %w(We hold these truths to)
      root = MerkleTree::Node.create_from(data)
      leaf_padding = root.right.left.right.value
      internal_padding = root.right.right.value

      expect(leaf_padding).not_to eq internal_padding
    end
  end
end
