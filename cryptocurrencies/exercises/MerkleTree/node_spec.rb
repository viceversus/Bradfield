require 'rspec'
require './node'

describe MerkleTree::Node do
  describe '.create_from' do
    it "returns the correct hash" do
      data = %w(We hold these truths to be self-evident that)
      root = MerkleTree::Node.create_from(data)
      expect(root.header).to eq "4a359c93d6b6c9beaa3fe8d8e68935aa5b5081bd2603549af88dee298fbfdd0a"
    end

    it "creates hash when there are odd numbers of words" do
      data = %w(We hold these truths to be self-evident)
      expect { MerkleTree::Node.create_from(data) }.to_not raise_error
    end

    it "uses a different padding strategy for internal and leaf nodes" do
      data = %w(We hold these truths to)
      root = MerkleTree::Node.create_from(data)
      leaf_padding = root.right.left.right.header
      internal_padding = root.right.right.header

      expect(leaf_padding).not_to eq internal_padding
    end
  end

  describe '#generate_proof' do
    let(:tree) { MerkleTree::Node.create_from(data) }

    context 'simple tree' do
      let(:data) { %w(A B C) }

      it "returns all relevant hashes for a block" do
        expect(
          tree.generate_proof(tree.right.header)
        ).to eq([tree.left.header, tree.right.header])
      end
    end

    context 'large tree' do
      let(:data) { %w(A B C D E F G H) }

      it "returns all relevant hashes for a block" do
        expect(
          tree.generate_proof(tree.right.left.left.header)
        ).to eq([
          tree.right.left.left.header,
          tree.right.left.right.header,
          tree.right.left.header,
          tree.right.right.header,
          tree.left.header,
          tree.right.header
        ])
      end
    end
  end

  describe '.verify_inclusion' do
    let(:tree) { MerkleTree::Node.create_from(data) }
    let(:data) { %w(A B C D E F G H) }
    let(:proof) { [
      tree.right.left.left.header,
      tree.right.left.right.header,
      tree.right.left.header,
      tree.right.right.header,
      tree.left.header,
      tree.right.header
    ] }

    it "returns true when proof is accurate" do
      expect(MerkleTree::Node.verify_inclusion(tree.right.left.left.header, proof, tree.header)).to eq(true)
    end

    it "returns false when proof is inaccurate" do
      expect(MerkleTree::Node.verify_inclusion(tree.right.left.left.header, proof, tree.left.left.header)).to eq(false)
    end
  end
end
