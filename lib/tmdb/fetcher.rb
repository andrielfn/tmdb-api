class APIKeyNotSet < StandardError; end

module TMDb
  module Fetcher
    include HTTParty
    base_uri 'http://api.themoviedb.org/3/'
    headers 'Accept' => 'application/json'
    format :json

    def self.get(url, options = {})
      verify_api!

      options.merge!(api_key: TMDb.api_key)

      result = super(url, query: options)

      if result.success?
        result
      else
        raise JSON.parse(result.response.body)['status_message']
      end
    end

    def self.verify_api!
      raise APIKeyNotSet if TMDb.api_key.nil?
    end
  end
end
