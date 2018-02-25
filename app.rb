require 'sinatra'
require './lib/client'
require './lib/calendar'

get '/' do
  send_file File.expand_path('index.html', settings.public_folder)
end

get '/cal' do
  halt 422, 'Missing token parameter' unless params.has_key?('token')

  content_type 'text/calendar'
  token = params['token']

  entries = Client.entries(token)
  if params['debug']
    content_type :json
    return JSON.dump(entries.map(&:data))
  end

  calendar = Calendar.new(entries)
  calendar.ical
end
