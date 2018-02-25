require 'sinatra'
require 'faraday'

get '/cal.ical' do
  content_type :json
  token = params['token']
  # TODO: Fail if token missing

  resp = Faraday.new(url: 'https://api.toshl.com/entries') do |faraday|
    faraday.basic_auth(token, nil)
    faraday.adapter  Faraday.default_adapter
    faraday.params[:expand] = false
    faraday.params[:per_page] = 500
    faraday.params[:type] = :expense
    faraday.params[:from] = '2018-01-01'
    faraday.params[:to] = '2019-01-01'
  end.get.body
  resp = JSON.parse(resp).select { |entry| entry.has_key?('repeat') }

  JSON.dump resp
end
