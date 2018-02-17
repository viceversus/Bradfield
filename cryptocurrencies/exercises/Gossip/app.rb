require 'sinatra/base'
require 'sinatra/json'
require './services/PeersService'
require './models/Peer'


module Gossip
  class Server < Sinatra::Base
    set :port, ENV['PORT']

    begin
      seeds = ENV['SEED_IDS'].split(',')
    rescue
      raise "Please provide at least 1 SEED_ID"
    end

    id = ENV['PORT']
    peers_service = PeersService.new(id, seeds)
    peers_service.bootstrap

    get '/peers.json' do
      content_type :json
      me = peers_service.me
      json peers_service.peers.merge({ me.id => me })
    end

    get '/' do
      @port = id
      @peers = peers_service.peers
      @book_title = peers_service.me.book
      slim :index
    end


    run! if __FILE__ == $0
  end
end
