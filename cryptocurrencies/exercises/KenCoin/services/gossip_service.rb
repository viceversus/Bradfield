require_relative './request_service'

module KenCoin
  module GossipService
    extend self

    def gossip(original_sender, blockchain, peers, params = {})
      params['uuid'] = SecureRandom.uuid unless params.has_key? 'uuid'
      params['ttl'] = 3 unless params.has_key? 'ttl'
      body = body_params_from(original_sender, blockchain, params)

      uris = peers.map { |port, _| construct_uri_from(port) }

      thread = Thread.new do
        RequestService.post_concurrent(uris, body)
      end

      thread.join
    end

    private
    def construct_uri_from(port)
      "http://localhost:#{port}/gossip.json"
    end

    def body_params_from(original_sender, blockchain, params)
      {
        uuid: params['uuid'],
        original_sender: original_sender,
        blockchain: blockchain,
        ttl: params['ttl']
      }
    end
  end
end
