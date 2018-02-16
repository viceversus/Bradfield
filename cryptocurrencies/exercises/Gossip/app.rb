require 'sinatra'

set :port, ENV['PORT']

begin
  seeds = ENV['SEED_IDS'].split(',')
rescue
  raise "Please provide at least 1 SEED_ID"
end

id = ENV['PORT']

get '/peers' do

end

get '/' do
  @port = id
  slim :index
end
