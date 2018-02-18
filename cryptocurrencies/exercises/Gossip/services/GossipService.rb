require './services/RequestService'

module Gossip
  class GossipService
    def self.gossip(subject, peers, params = {})
      params['uuid'] = SecureRandom.uuid unless params.has_key? 'uuid'
      params['ttl'] = 3 unless params.has_key? 'ttl'
      body = body_params_from(subject, params)
      threads = []

      peers.each do |id, peer|
        puts '*' * 50
        puts "Gossiping to peer", peer
        puts '*' * 50
        thread = Thread.new do
          RequestService.post(construct_uri_from(id), body)
        end
        threads.push thread
      end

      threads.each { |t| t.join }
    end

    private
    def self.construct_uri_from(id)
      "http://localhost:#{id}/gossip.json"
    end

    def self.body_params_from(subject, params)
      {
        uuid: params['uuid'],
        id: subject.id,
        book: subject.book,
        version: subject.version,
        ttl: params['ttl']
      }
    end
  end
end
