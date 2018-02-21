require_relative './request_service'
require_relative '../models/peer'

module KenCoin
  class PeersService
    attr_reader :peers, :me

    def initialize(my_port, seed_ports)
      @me = Peer.bootstrap(my_port)
      @peers = {}
    end

    def bootstrap(seeds)
      seeds.each do |seed_port|
        if req = RequestService.get(construct_uri_from(seed_port))
          peers_hash = JSON.parse(req.body)
          peers_hash.each do |port, peer|
            update_peer(peer['port'], peer['public_key'])
          end
        end
      end
    end

    def update_peer(port, public_key)
      peer = @peers[port]
      if !peer || (peer.port != @me.port)
        @peers[port] = Peer.new(port, public_key)
      end
    end

    private
    def construct_uri_from(port)
      "http://localhost:#{port}/peers.json"
    end
  end
end
