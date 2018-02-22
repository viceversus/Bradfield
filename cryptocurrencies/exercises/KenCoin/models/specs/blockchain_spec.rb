require_relative '../blockchain.rb'
require_relative '../block.rb'
require_relative '../transaction.rb'

describe KenCoin::Blockchain do
  subject { KenCoin::Blockchain.new }
  let(:sender) { OpenSSL::PKey::RSA.new(2048) }
  let(:recipient) { OpenSSL::PKey::RSA.new(2048) }
  let(:amount) { 2 }
  let(:transaction) {
    KenCoin::Transaction.new(sender.public_key, recipient.public_key, amount)
  }

  before do
    allow(KenCoin::ProofOfWorkService).to receive(:mint).and_return(42)
    transaction.sign(sender)
  end

  describe '#valid?' do
    let(:another_valid_transaction) { KenCoin::Transaction.new(sender.public_key, recipient.public_key, 5) }

    before do
      another_valid_transaction.sign(sender)
      subject.add_block another_valid_transaction
    end

    context 'when all blocks are valid' do
      it 'returns true' do
        new_chain = KenCoin::Blockchain.new(subject.blocks)
        expect(new_chain.valid?).to eq true
      end
    end

    context 'when all blocks are not valid' do
      let(:invalid_block) { KenCoin::Block.new(another_valid_transaction, 'invalid_hash') }

      before do
        another_valid_transaction.sign(sender)
      end

      it 'returns false' do
        invalid_blocks = subject.blocks
        invalid_blocks.push invalid_block
        new_chain = KenCoin::Blockchain.new(invalid_blocks)

        expect(new_chain.valid?).to eq false
      end
    end
  end

  describe '#add_block' do
    context 'when there are no blocks' do
      it 'adds a genesis block' do
        subject.add_block transaction
        expect(subject.blocks.length).to eq 2
      end

      it 'genesis block gives the initial user coins' do
        subject.add_block transaction
        genesis_block = subject.blocks.first
        expect(genesis_block.content.to.export).to eq sender.public_key.export
        expect(genesis_block.content.amount).to eq KenCoin::Blockchain::BLOCK_REWARD
      end

      it 'adds the transaction' do
        subject.add_block transaction
        expect(subject.blocks.last.content).to eq transaction
      end

      context 'and the transaction is greater than block reward' do
        let(:invalid_transaction) { KenCoin::Transaction.new(sender.public_key, recipient.public_key, 200) }

        before do
          invalid_transaction.sign(sender)
        end

        it 'does not add the transaction but creates the genesis block' do
          subject.add_block invalid_transaction
          expect(subject.blocks.length).to eq 1
          expect(subject.blocks.first.content.to.export).to eq sender.public_key.export
          expect(subject.blocks.first.content.amount).to eq KenCoin::Blockchain::BLOCK_REWARD
        end
      end
    end

    context 'when there are already blocks' do
      before do
        subject.add_block transaction
      end

      context 'and that user has enough coins in their account' do
        let(:another_valid_transaction) { KenCoin::Transaction.new(sender.public_key, recipient.public_key, 10) }

        before do
          another_valid_transaction.sign(sender)
        end

        it 'creates a block with previous hash' do
          expect { subject.add_block(another_valid_transaction) }
            .to change { subject.blocks.length }.from(2).to(3)
        end
      end

      context 'and that user does not have enough coins' do
        let(:invalid_transaction) { KenCoin::Transaction.new(sender.public_key, recipient.public_key, 99) }

        before do
          invalid_transaction.sign(sender)
        end

        it 'does not create a block' do
          expect { subject.add_block(invalid_transaction) }
            .to change { subject.blocks.length }.by(0)
        end
      end

      context 'and signature is not verified by the sender' do
        let(:invalid_transaction) { KenCoin::Transaction.new(sender.public_key, recipient.public_key, 10) }

        it 'does not create a block' do
          expect { subject.add_block(invalid_transaction) }
            .to change { subject.blocks.length }.by(0)
        end
      end
    end
  end
end
