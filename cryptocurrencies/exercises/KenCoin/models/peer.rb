require 'OpenSSL'

module KenCoin
  class Peer
    attr_reader :port, :public_key
    attr_accessor :private_key

    def self.parse_json(json)
      Peer.new(json['port'], OpenSSL::PKey::RSA.new(json['public_key']))
    end

    def initialize(port, public_key)
      @port = port
      @public_key = public_key
      @private_key = nil
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
        public_key: @public_key.export
      }.to_json
    end
  end
end
