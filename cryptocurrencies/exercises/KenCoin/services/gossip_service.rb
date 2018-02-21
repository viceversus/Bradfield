require_relative './request_service'

module KenCoin
  module GossipService
    extend self

    def gossip(id, blockchain, peers, params = {})
      params['uuid'] = SecureRandom.uuid unless params.has_key? 'uuid'
      params['ttl'] = 3 unless params.has_key? 'ttl'
      body = body_params_from(id, blockchain, params)

      uris = peers.map { |id, _| construct_uri_from(id) }

      thread = Thread.new do
        RequestService.post_concurrent(uris, body)
      end

      thread.join
    end

    private
    def construct_uri_from(id)
      "http://localhost:#{id}/gossip.json"
    end

    def body_params_from(id, blockchain, params)
      {
        uuid: params['uuid'],
        id: id,
        blockchain: blockchain,
        ttl: params['ttl']
      }
    end
  end
end
