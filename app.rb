require 'dotenv/load'

require 'sinatra'
require 'sinatra/custom_logger'
require 'logglier'

require './lib/client'
require './lib/calendar'

if production? && ENV.has_key?('LOGGLY_TOKEN')
  set :logger,
      Logglier.new(
        "https://logs-01.loggly.com/inputs/#{ENV['LOGGLY_TOKEN']}/tag/ruby/",
        format: :json,
        threaded: true
      )
end

get '/' do
  send_file File.expand_path('index.html', settings.public_folder)
end

get '/cal' do
  unless params.has_key?('token')
    logger.info 'Tried to fetch /cal without a token'
    halt 422, 'Missing token parameter'
  end

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
