require_relative 'proof_of_work.rb'

describe ProofOfWork::Worker do
  describe '#verify' do
    let(:mock_hashing_service) { double('HashingService', hexdigest: "00000ae1738294y9") }

    subject { ProofOfWork::Worker.new(mock_hashing_service) }

    it 'returns true given the correct challenge, work_factor, and token' do
      expect(subject.verify('asdf', 5, 12)).to be_truthy
    end

    it 'returns false if it doesn not match the work factor' do
      expect(subject.verify('asdf', 6, 12)).to be_falsy
    end
  end

  describe '#verify' do
    let(:mock_hashing_service) { double('HashingService', hexdigest: "00000ae1738294y9") }

    subject { ProofOfWork::Worker.new(mock_hashing_service) }

    it 'returns true given the correct challenge, work_factor, and token' do
      expect(subject.verify('asdf', 5, 12)).to be_truthy
    end

    it 'returns false if it doesn not match the work factor' do
      expect(subject.verify('asdf', 6, 12)).to be_falsy
    end
  end
end
