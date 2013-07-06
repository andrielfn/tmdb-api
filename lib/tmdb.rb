require "httparty"
require "json"

require "tmdb/fetcher"
require "tmdb/searchable"
require "tmdb/movie"
require "tmdb/changes"
require "tmdb/version"

module TMDb
  class << self
    # Set the API Key that will be use to fetch the data.
    attr_accessor :api_key

    # Set the default language of the fetched data.
    attr_accessor :default_language
  end
end
