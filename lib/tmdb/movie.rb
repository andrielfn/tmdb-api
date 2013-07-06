module TMDb
  class Movie
    extend Searchable

    # Movie attributes
    ATTRIBUTES = :id, :adult, :backdrop_path, :belongs_to_collection, :budget,
                 :genres, :homepage, :imdb_id, :original_title, :overview,
                 :popularity, :poster_path, :production_companies, :runtime,
                 :production_countries, :release_date, :revenue, :spoken_languages,
                 :status, :tagline, :title, :vote_average, :vote_count

    attr_accessor *ATTRIBUTES

    def initialize(attrs)
      ATTRIBUTES.each { |attr| instance_variable_set("@#{attr}", attrs[attr.to_s]) }
    end

    # Get the basic movie information for a specific movie ID.
    #
    # id - Movie ID.
    # options - The hash options used to filter the search (default: {}):
    #           :language - Language of the result data (ISO 639-1 codes) (default: en).
    #
    # Examples
    #
    # TMDb::Movie.find(24)
    #
    # TMDb::Movie.find(32123, language: 'pt')
    #
    def self.find(id, options = {})
      new Fetcher::get("/movie/#{id}", options)
    end

    # Get the alternative titles for a specific movie ID.
    #
    # options - The hash options used to filter the search (default: {}):
    #           :country - Titles for a specific country (ISO 3166-1 code).
    #
    # Examples
    #
    # TMDb::Movie.alternative_titles(598, country: 'br')
    #
    def self.alternative_titles(id, options = {})
      result = Fetcher::get("/movie/#{id}/alternative_titles", options)
      result['titles']
    end

    # Get the images (posters and backdrops) for a specific movie id.
    #
    # options - The hash options used to filter the search (default: {}):
    #           :language - Images of a specific language (ISO 639-1 code).
    #
    # Examples
    #
    # TMDb::Movie.find(598).images
    #
    # movie = TMDb::Movie.images(598, language: 'pt')
    #
    def self.images(id, options = {})
      Fetcher::get("/movie/#{id}/images", options)
    end

    # Get the plot keywords for a specific movie id.
    #
    # options - The hash options used to filter the search (default: {}):
    #           :language - Images of a specific language (ISO 639-1 code).
    #
    # Examples
    #
    # TMDb::Movie.keywords(331, language: pt)
    #
    def self.keywords(id, options = {})
      result = Fetcher::get("/movie/#{id}/keywords", options)
      result['keywords']
    end

    # Get the release date by country for a specific movie id.
    #
    # Examples
    #
    # TMDb::Movie.releases(8711)
    #
    def self.releases(id)
      result = Fetcher::get("/movie/#{id}/releases")
      result['countries']
    end

    # Get the list of upcoming movies. This list refreshes every day.
    # The maximum number of items this list will include is 100.
    #
    # options - The hash options used to filter the search (default: {}):
    #           :page - Page.
    #           :language - Images of a specific language (ISO 639-1 code).
    #
    # Examples
    #
    # TMDb::Movie.upcoming
    # TMDb::Movie.upcoming(page: 3, language: 'pt')
    #
    def self.upcoming(options = {})
      response = Fetcher::get('/movie/upcoming', options)
      response['results'].map { |movie| new(movie) }
    end
  end
end
