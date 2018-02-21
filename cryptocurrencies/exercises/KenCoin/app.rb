require 'sinatra/base'
require 'sinatra/json'
require 'rufus-scheduler'

require_relative './services/gossip_service'
require_relative './services/peers_service'
require_relative './services/blockchain_service'

module KenCoin
  class Server < Sinatra::Base
    set :port, ENV['PORT']
    seeds = (ENV['SEED_IDS'] || '').split(',')
    port = ENV['PORT']

    peers_service = KenCoin::PeersService.new(port, seeds)
    peers_service.bootstrap(seeds)
    cache = []
    BlockchainService.initialize_blockchain
    interval = (4..10).to_a.sample

    Rufus::Scheduler.singleton.every "#{interval}s" do
      recipient = peers_service.peers.values.sample
      if recipient
        BlockchainService.generate_transaction(peers_service.me.private_key, recipient.public_key, (1..5).to_a.sample)

        GossipService.gossip(port, BlockchainService.current_blockchain, peers_service.peers)
      end
    end

    get '/peers.json' do
      content_type :json
      me = peers_service.me
      json peers_service.peers.merge({ me.port => me })
    end

    get '/' do
      @port = port
      @peers = peers_service.peers
      @cache = cache
      @blockchain = BlockchainService.current_blockchain

      slim :index
    end

    post '/gossip.json' do
      content_type :json
      body = JSON.parse(request.body.read)

      new_blockchain = BlockchainService.blockchain_from_json(body['blockchain'])

      p new_blockchain

      # return status 200 if cache.include?(body['uuid']) || peers_service.me.id == body['id']
      #
      # cache.push body['uuid']
      # # peers_service.update_peer(body['id'], body['book'], body['version'])
      # ttl = body['ttl'].to_i - 1
      # return status 200 if ttl == 0
      #
      # params = {
      #   'uuid' => body['uuid'],
      #   'ttl' => ttl
      # }
      # GossipService.gossip(peers_service.peers[body['id']], peers_service.peers, params)
      # status 200
    end

    run! if __FILE__ == $0
  end
end
