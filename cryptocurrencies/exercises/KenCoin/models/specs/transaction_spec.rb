require_relative '../transaction.rb'
require 'OpenSSL'

describe KenCoin::Transaction do
  let(:sender) { OpenSSL::PKey::RSA.new(2048) }
  let(:sender_pubkey_snippet) { KenCoin::Transaction::RSA_LINE_MATCHER.match(sender.public_key.export)[0] }
  let(:recipient) { OpenSSL::PKey::RSA.new(2048) }
  let(:recipient_pubkey_snippet) { KenCoin::Transaction::RSA_LINE_MATCHER.match(recipient.public_key.export)[0] }
  let(:signature) { sender.private_encrypt("#{sender_pubkey_snippet}||#{recipient_pubkey_snippet}||10") }

  describe '#is_valid' do
    context 'when signature is not verified' do
      let(:unverified_sender) { OpenSSL::PKey::RSA.new(2048) }
      let(:unverified_sender_pubkey_snippet) { KenCoin::Transaction::RSA_LINE_MATCHER.match(unverified_sender.public_key.export)[0] }
      let(:transaction) {
        KenCoin::Transaction.new(
          unverified_sender.public_key,
          recipient.public_key,
          10,
          signature
        )
      }

      it 'returns false' do
        expect(transaction.is_valid?).to eq false
      end
    end

    context 'when signature is verified' do
      let(:transaction) {
        KenCoin::Transaction.new(sender.public_key, recipient.public_key, 10, signature)
      }

      it 'returns true' do
        expect(transaction.is_valid?).to eq true
      end
    end
  end
end
