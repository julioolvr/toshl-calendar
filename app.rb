require 'sinatra'
require './lib/client'
require './lib/calendar'

get '/cal' do
  content_type 'text/calendar'
  token = params['token']
  # TODO: Fail if token missing

  # TODO: Check error propagation from `Client`
  entries = Client.entries(token)
  if params['debug']
    content_type :json
    return JSON.dump(entries.map(&:data))
  end

  calendar = Calendar.new(entries)
  calendar.ical
end
