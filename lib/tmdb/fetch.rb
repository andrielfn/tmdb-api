module TMDb
  module Fetch
    include HTTParty
    base_uri 'http://api.themoviedb.org/3/'
    headers 'Accept' => 'application/json'
    format :json

    def self.get(url, options = {})
      options.merge!(api_key: TMDb.api_key)
      super(url, query: options)
    end
  end
end
