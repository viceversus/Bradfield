require './services/RequestService'
require './models/Peer'

module Gossip
  class PeersService
    attr_reader :peers, :me

    def initialize(my_id, seed_ids)
      @me = Peer.bootstrap(my_id)
      @peers = {}
      seed_ids.each do |id|
        @peers[id] = Peer.new(id, '', 0)
      end

    end

    def bootstrap
      @peers.clone.each do |id, peer|
        if req = RequestService.get(construct_uri_from(id))
          peers_hash = JSON.parse(req.body)
          peers_hash.each do |id, peer|
            update_peer(peer['id'], peer['book'], peer['version'])
          end
        end
      end
    end

    def update_peer(id, book, version)
      peer = @peers[id]
      if !peer || (peer.id != me.id && version > peer.version)
        @peers[id] = Peer.new(id, book, version)
      end
    end

    private
    def construct_uri_from(id)
      "http://localhost:#{id}/peers.json"
    end
  end
end
