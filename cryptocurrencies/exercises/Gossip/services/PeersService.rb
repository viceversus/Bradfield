require_relative 'RequestService'

module Gossip
  class PeersService
    def initialize(ids)
      @uris = ids.map { |id| construct_uri_from(id) }
    end

    def bootstrap
      @uris.each do |uri|
        req = RequestService.get(uri + '/peers.json')
      end
    end

    private
    def construct_uri_from(id)
      "http://localhost:#{id}"
    end
  end
end
