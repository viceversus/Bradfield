require 'OpenSSL'
require 'Digest'
require 'Base64'

module KenCoin
  class Transaction
    RSA_LINE_MATCHER = /(?<=\n)(.*?)(?=\n)/
    attr_reader :from, :to, :amount, :signature

    def self.json_parse(json_string)
      json = JSON.parse(json_string)
      
      from = json['from'] == '' ? json['from'] : OpenSSL::PKey::RSA.new(json['from'])
      to = OpenSSL::PKey::RSA.new(json['to'])
      amount = json['amount']
      signature = Base64.decode64(json['signature']).encode('ascii-8bit')
      Transaction.new(from, to, amount, signature)
    end

    def initialize(from, to, amount, signature='')
      @from = from
      @to = to
      @amount = amount
      @signature = signature
    end

    def is_valid?
      amount > 0 && pkey_valid?
    end

    def sign(pkey)
      @signature = pkey.private_encrypt(data_hash)
    end

    def to_json(opts={})
      from = @from == '' ? '' : @from.export

      {
        from: from,
        to: @to.export,
        amount: @amount,
        signature: Base64.encode64(@signature).encode('utf-8')
      }.to_json
    end

    private
    def data_hash
      ::Digest::SHA2.hexdigest("#{@from.export}||#{@to.export}||#{@amount}")
    end

    def pkey_valid?
      pub_key = OpenSSL::PKey::RSA.new(@from)
      message = pub_key.public_decrypt(@signature)

      message == data_hash
    rescue OpenSSL::PKey::RSAError
      false
    end
  end
end
