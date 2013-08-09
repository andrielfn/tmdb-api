require 'httparty'
require 'json'

require 'tmdb-api/httparty'

require 'tmdb-api/base'
require 'tmdb-api/searchable'

require 'tmdb-api/movie'
require 'tmdb-api/genre'
require 'tmdb-api/production_company'
require 'tmdb-api/production_country'
require 'tmdb-api/spoken_language'
require 'tmdb-api/changes'

require 'tmdb-api/version'

module TMDb
  class << self
    # Set the API Key that will be use to fetch the data.
    attr_accessor :api_key

    # Set the default language of the fetched data.
    attr_accessor :default_language
  end
end
