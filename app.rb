require 'sinatra'
require './lib/client'

get '/cal.ical' do
  content_type :json
  token = params['token']
  # TODO: Fail if token missing

  # TODO: Check error propagation from `Client`
  JSON.dump(Client.entries(token))
end
