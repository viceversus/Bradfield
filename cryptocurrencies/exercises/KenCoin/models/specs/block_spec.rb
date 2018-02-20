require_relative '../block.rb'

describe KenCoin::Block do
  describe '#initialize' do
    let(:proof_of_work_service) { double('pow_service') }
    let(:previous_hash) { 'old_hash' }

    it 'calculates a nonce for the previous hash' do
      expect(proof_of_work_service).to receive(:mint).with(previous_hash, 4)
      KenCoin::Block.new('example', previous_hash, proof_of_work_service)
    end
  end
end
