require './request_service'

module KenCoin
  class GossipService
    def self.gossip(subject, peers, params = {})
      params['uuid'] = SecureRandom.uuid unless params.has_key? 'uuid'
      params['ttl'] = 3 unless params.has_key? 'ttl'
      body = body_params_from(subject, params)

      uris = peers.map { |id, _| construct_uri_from(id) }
      thread = Thread.new do
        RequestService.post_concurrent(uris, body)
      end

      thread.join
    end

    private
    def self.construct_uri_from(id)
      "http://localhost:#{id}/gossip.json"
    end

    def self.body_params_from(subject, params)
      {
        uuid: params['uuid'],
        id: subject.id,
        blockchain: subject.blockchain,
        ttl: params['ttl']
      }
    end
  end
end
