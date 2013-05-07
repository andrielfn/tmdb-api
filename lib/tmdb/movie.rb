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
    # TMDb::Movie.find(598).alternative_titles
    #
    # movie = TMDb::Movie.find(598)
    # movie.alternative_titles(country: 'br')
    #
    def alternative_titles(options = {})
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
    # movie = TMDb::Movie.find(598)
    # movie.images(language: 'pt')
    #
    def images(options = {})
      Fetcher::get("/movie/#{id}/images", options)
    end
  end
end
