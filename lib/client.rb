require 'faraday'
require 'nitlink/response'
require 'timerizer'
require_relative './entry'

class Client
  def self.entries(token)
    date_from = 1.year.ago
    date_to = 1.year.from_now
    date_format = '%Y-%m-%d'

    conn = Faraday.new(url: 'https://api.toshl.com') do |faraday|
      faraday.basic_auth(token, nil)
      faraday.response :logger
      faraday.adapter Faraday.default_adapter

      faraday.params[:expand] = false
      faraday.params[:per_page] = 500
      faraday.params[:type] = :expense
      faraday.params[:from] = date_from.strftime(date_format)
      faraday.params[:to] = date_to.strftime(date_format)
    end

    response = conn.get '/entries'
    results = JSON.parse(response.body)

    while response.links.by_rel('next')
      response = conn.get(response.links.by_rel('next').target)
      results += JSON.parse(response.body)
    end

    results
      .select { |entry| entry.has_key?('repeat') }
      .uniq { |entry| entry['repeat']['id'] }
      .map { |data| Entry.new(data) }
  end
end
