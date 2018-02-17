require './services/RequestService'
require './models/Library'

module Gossip
  class PeersService
    attr_reader :peers, :me

    def initialize(my_id, seed_ids)
      @me = Peer.new(my_id, Library.sample, 1)
      @peers = {}
      seed_ids.each do |id|
        @peers[id] = Peer.new(id, '', 0)
      end

    end

    def bootstrap
      @peers.each do |id, peer|
        if req = RequestService.get(construct_uri_from(id) + '/peers.json')
          peers_hash = JSON.parse(req.body)
          peers_hash.each do |id, peer|
            @peers[id] = Peer.from_hash(peer)
          end
        end
      end
    end

    private
    def construct_uri_from(id)
      "http://localhost:#{id}"
    end
  end
end
