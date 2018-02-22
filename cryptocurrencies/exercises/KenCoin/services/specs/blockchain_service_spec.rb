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

  describe '#fork_choice' do
    context 'when our blockchain is longer' do
      let(:their_blocks) { [block, block, block] }

      it 'chooses our blockchain' do
        subject.fork_choice(their_blockchain)
        expect(subject.current_blockchain).to eq our_blockchain
      end
    end

    context 'when our blockchain is the same length' do
      let(:their_blocks) { [block, block, block, block] }

      it 'chooses our blockchain' do
        subject.fork_choice(their_blockchain)
        expect(subject.current_blockchain).to eq our_blockchain
      end
    end

    context 'when our blockchain is shorter and new chain is valid' do
      let(:their_blocks) { [block, block, block, block, block] }

      it 'chooses our blockchain' do
        allow(their_blockchain).to receive(:valid?).and_return(true)
        subject.fork_choice(their_blockchain)
        expect(subject.current_blockchain).to eq their_blockchain
      end
    end

    context 'when our blockchain is shorter and new chain is invalid' do
      let(:their_blocks) { [block, block, block, block, block] }

      it 'chooses our blockchain' do
        allow(their_blockchain).to receive(:valid?).and_return(false)
        subject.fork_choice(their_blockchain)
        expect(subject.current_blockchain).to eq our_blockchain
      end
    end
  end
end
