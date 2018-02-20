require 'OpenSSL'

module KenCoin
  class Transaction
    RSA_LINE_MATCHER = /(?<=\n)(.*?)(?=\n)/
    attr_reader :from, :to, :amount, :signature

    def initialize(from, to, amount, signature)
      @from = from
      @to = to
      @amount = amount
      @signature = signature
    end

    def is_valid?
      pub_key = OpenSSL::PKey::RSA.new(@from)
      message = pub_key.public_decrypt(@signature)

      true
    rescue OpenSSL::PKey::RSAError
      false
    end
  end
end
