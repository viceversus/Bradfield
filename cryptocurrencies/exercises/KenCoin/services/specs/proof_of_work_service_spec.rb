require_relative '../proof_of_work_service.rb'

describe KenCoin::ProofOfWorkService do
  let(:challenge) { 'asdf' }
  let(:work_factor) { 5 }
  let(:token) { 12 }

  subject { KenCoin::ProofOfWorkService }

  describe '#verify' do
    before do
      expect(::Digest::SHA2).to receive(:hexdigest).with("asdf12").and_return("#{'0' * work_factor}ab3k1fkdlsj")
    end

    context 'and cache is empty' do
      it 'returns true given the correct challenge, work_factor, and token' do
        expect(subject.verify(challenge, work_factor, token)).to be_truthy
      end

      it 'returns false if it doesn not match the work factor' do
        expect(subject.verify(challenge, work_factor + 1, token)).to be_falsy
      end
    end
  end

  describe '#mint' do
    let(:token) { 0 }

    context 'and cache is populated' do
      before do
        allow(::Digest::SHA2).to receive(:hexdigest).with("asdf0").and_return("#{'0' * work_factor}ab3k1fkdlsj")
        allow(::Digest::SHA2).to receive(:hexdigest).with("asdf1").and_return("#{'0' * (work_factor - 1)}ab3k1fkdlsj")
        allow(::Digest::SHA2).to receive(:hexdigest).with("asdf2").and_return("#{'0' * work_factor}ab3k1fkdlsj")
      end

      it 'returns the next token valid token' do
        expect(subject.mint(challenge, work_factor)).to eq 0
        expect(subject.mint(challenge, work_factor)).to eq 2
      end
    end
  end
end
