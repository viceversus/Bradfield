require 'OpenSSL'
require 'Digest'

module KenCoin
  class Transaction
    RSA_LINE_MATCHER = /(?<=\n)(.*?)(?=\n)/
    attr_reader :from, :to, :amount, :signature

    def initialize(from, to, amount)
      @from = from
      @to = to
      @amount = amount
      @signature = ''
    end

    def is_valid?
      amount > 0 && pkey_valid?
    end

    def sign(pkey)
      @signature = pkey.private_encrypt(data_hash)
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
