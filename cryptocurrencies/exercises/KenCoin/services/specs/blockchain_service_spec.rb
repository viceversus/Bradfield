require_relative '../blockchain_service.rb'

describe KenCoin::BlockchainService do
  subject { KenCoin::BlockchainService }
  let(:our_blockchain) { double('blockchain') }
  let(:their_blockchain) { double('blockchain') }
  let(:block) { double('block') }
  let(:our_blocks) { [block, block, block, block] }
  let(:their_blocks) { [] }

  before do
    KenCoin::BlockchainService.current_blockchain = our_blockchain
    allow(our_blockchain).to receive(:blocks).and_return(our_blocks)
    allow(their_blockchain).to receive(:blocks).and_return(their_blocks)
  end

  describe '#choose_blockchain' do
    context 'when our blockchain is longer' do
      let(:their_blocks) { [block, block, block] }

      it 'chooses our blockchain' do
        subject.choose_blockchain(our_blockchain, their_blockchain)
        expect(subject.current_blockchain).to eq our_blockchain
      end
    end

    context 'when our blockchain is the same length' do
      let(:their_blocks) { [block, block, block, block] }

      it 'chooses our blockchain' do
        subject.choose_blockchain(our_blockchain, their_blockchain)
        expect(subject.current_blockchain).to eq our_blockchain
      end
    end

    context 'when our blockchain is the same shorter' do
      let(:their_blocks) { [block, block, block, block, block] }

      it 'chooses our blockchain' do
        subject.choose_blockchain(our_blockchain, their_blockchain)
        expect(subject.current_blockchain).to eq their_blockchain
      end
    end
  end
end
