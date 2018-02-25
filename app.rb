require 'sinatra'
require 'faraday'

get '/cal.ical' do
  content_type :json
  token = params['token']
  # TODO: Fail if token missing

  resp = Faraday.new(url: 'https://api.toshl.com/me') do |faraday|
    faraday.basic_auth(token, nil)
    faraday.adapter  Faraday.default_adapter
  end.get.body
end
