require_relative '../transaction.rb'
require 'OpenSSL'

describe KenCoin::Transaction do
  let(:sender) { OpenSSL::PKey::RSA.new(2048) }
  let(:recipient) { OpenSSL::PKey::RSA.new(2048) }
  let(:signature) { sender.private_encrypt("#{sender_pubkey_snippet}||#{recipient_pubkey_snippet}||10") }

  describe '#is_valid' do
    context 'when signature is not verified' do
      let(:unverified_sender) { OpenSSL::PKey::RSA.new(2048) }
      let(:transaction) {
        KenCoin::Transaction.new(
          sender.public_key,
          recipient.public_key,
          10
        )
      }

      before do
        transaction.sign(unverified_sender)
      end

      it 'returns false' do
        expect(transaction.is_valid?).to eq false
      end
    end

    context 'when there is no signature' do
      let(:transaction) {
        KenCoin::Transaction.new(sender.public_key, recipient.public_key, 10)
      }

      it 'returns false' do
        expect(transaction.is_valid?).to eq false
      end
    end

    context 'when signature is verified and amount is invalid' do
      let(:transaction) {
        KenCoin::Transaction.new(sender.public_key, recipient.public_key, -10)
      }

      before do
        transaction.sign(sender)
      end

      it 'returns false' do
        expect(transaction.is_valid?).to eq false
      end
    end

    context 'when signature is verified and amount is valid' do
      let(:transaction) {
        KenCoin::Transaction.new(sender.public_key, recipient.public_key, 10)
      }

      before do
        transaction.sign(sender)
      end

      it 'returns true' do
        expect(transaction.is_valid?).to eq true
      end
    end
  end
end
