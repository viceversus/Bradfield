module Crypto
  class Transaction
    def initialize(from, to, amount, signature)
      @from = from
      @to = to
      @amount = amount
      @signature = signature
    end
  end
end
