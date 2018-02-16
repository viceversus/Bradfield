require 'sinatra/base'
require 'sinatra/json'
require './services/PeersService'

module Gossip
  class Server < Sinatra::Base
    set :port, ENV['PORT']

    begin
      seeds = ENV['SEED_IDS'].split(',')
    rescue
      raise "Please provide at least 1 SEED_ID"
    end

    id = ENV['PORT']
    peers = { hello: 'world' }

    get '/peers.json' do
      content_type :json
      json peers
    end

    get '/' do
      @port = id
      slim :index
    end

    service = PeersService.new(seeds)
    service.bootstrap

    run! if __FILE__ == $0
  end
end
