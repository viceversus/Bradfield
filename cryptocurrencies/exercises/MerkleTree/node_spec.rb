require 'rspec'
require './node'

describe MerkleTree::Node do
  describe '.create_from' do
    it "returns the correct hash" do
      data = %w(We hold these truths to be self-evident that)
      node = MerkleTree::Node.create_from(data)
      expect(node.value).to eq "4a359c93d6b6c9beaa3fe8d8e68935aa5b5081bd2603549af88dee298fbfdd0a"
    end
  end
end
