require 'Digest'

module ProofOfWork
  class Worker
    def initialize(hashing_service = ::Digest::SHA2, ttl = 10)
      @hashing_service = hashing_service
      @cache = []
      @ttl = ttl
    end

    def mint(challenge, work_factor)
      token_value = 0
      loop do
        if verify(challenge, work_factor, token_value)
          @cache.push Token.new(token_value)
          break
        end
        token_value += 1
      end

      token_value
    end

    def verify(challenge, work_factor, token_value)
      qualifies?(challenge, work_factor, token_value) && !cached?(token_value)
    end

    def qualifies?(challenge, work_factor, token_value)
      matcher = "0" * work_factor
      @hashing_service.hexdigest(challenge + token_value.to_s)[0...work_factor] == matcher
    end

    def cached?(token_value)
      @cache.any? do |token|
        token_in_cache = token.value == token_value
        cache_time_remains = Time.now.to_i - token.timestamp <= @ttl
        token_in_cache && cache_time_remains
      end
    end
  end

  class Token < Struct.new(:value, :timestamp)
    def initialize(value, timestamp = Time.now.to_i)
      super
    end
  end
end
