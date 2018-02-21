require 'OpenSSL'

module KenCoin
  class Peer
    attr_reader :port, :public_key
    attr_writer :private_key

    def initialize(port, public_key)
      @port = port
      @public_key = public_key
      @private_key = nil
    end

    def self.from_hash(hash)
      self.new(hash['id'], hash['public_key'])
    end

    def self.bootstrap(port)
      pkey = OpenSSL::PKey::RSA.new(2048)
      instance = self.new(port, pkey.public_key)
      instance.private_key = pkey
      instance
    end

    def to_json(_)
      {
        port: @port,
        public_key: @public_key
      }.to_json
    end
  end
end
