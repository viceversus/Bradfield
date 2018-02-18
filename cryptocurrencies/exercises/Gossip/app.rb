require 'sinatra/base'
require 'sinatra/json'
require 'rufus-scheduler'

require './services/GossipService'
require './services/PeersService'

module Gossip
  class Server < Sinatra::Base
    set :port, ENV['PORT']
    seeds = (ENV['SEED_IDS'] || '').split(',')
    id = ENV['PORT']

    peers_service = PeersService.new(id, seeds)
    peers_service.bootstrap
    cache = []

    Rufus::Scheduler.singleton.every '10s' do
      peers_service.me.update_book

      unless peers_service.peers.empty?
        GossipService.gossip(peers_service.me, peers_service.peers)
      end
    end

    get '/peers.json' do
      content_type :json
      me = peers_service.me
      json peers_service.peers.merge({ me.id => me })
    end

    get '/' do
      @port = id
      @peers = peers_service.peers
      @book_title = peers_service.me.book
      @cache = cache

      slim :index
    end

    post '/gossip.json' do
      content_type :json
      body = JSON.parse(request.body.read)
      return status 200 if cache.include?(body['uuid']) || peers_service.me.id == body['id']

      cache.push body['uuid']
      peers_service.update_peer(body['id'], body['book'], body['version'])
      ttl = body['ttl'].to_i - 1
      return status 200 if ttl == 0

      params = {
        'uuid' => body['uuid'],
        'ttl' => ttl
      }
      GossipService.gossip(peers_service.peers[body['id']], peers_service.peers, params)
      status 200
    end

    run! if __FILE__ == $0
  end
end
