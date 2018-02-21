require_relative '../blockchain.rb'
require_relative '../block.rb'
require_relative '../transaction.rb'

describe KenCoin::Blockchain do
  before do
    allow(KenCoin::ProofOfWorkService).to receive(:mint).and_return(42)
  end

  describe '#add_block' do
    subject { KenCoin::Blockchain.new }
    let(:sender) { OpenSSL::PKey::RSA.new(2048) }
    let(:sender_pubkey_snippet) { KenCoin::Transaction::RSA_LINE_MATCHER.match(sender.public_key.export)[0] }
    let(:recipient) { OpenSSL::PKey::RSA.new(2048) }
    let(:recipient_pubkey_snippet) { KenCoin::Transaction::RSA_LINE_MATCHER.match(recipient.public_key.export)[0] }
    let(:signature) { sender.private_encrypt("#{sender_pubkey_snippet}||#{recipient_pubkey_snippet}||#{amount}") }
    let(:amount) { 2 }
    let(:transaction) {
      KenCoin::Transaction.new(sender.public_key, recipient.public_key, amount)
    }

    before do
      transaction.sign(sender)
    end

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
