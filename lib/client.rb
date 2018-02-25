require 'faraday'
require 'nitlink/response'

class Client
  def self.entries(token)
    conn = Faraday.new(url: 'https://api.toshl.com') do |faraday|
      faraday.basic_auth(token, nil)
      faraday.response :logger
      faraday.adapter Faraday.default_adapter

      faraday.params[:expand] = false
      faraday.params[:per_page] = 500
      faraday.params[:type] = :expense
      faraday.params[:from] = '2018-01-01'
      faraday.params[:to] = '2019-01-01'
    end

    response = conn.get '/entries'
    results = JSON.parse(response.body)

    while response.links.by_rel('next')
      response = conn.get(response.links.by_rel('next').target)
      results += JSON.parse(response.body)
    end

    results.select { |entry| entry.has_key?('repeat') }
  end
end
