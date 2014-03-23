module TMDb
  class Movie < Base
    extend Searchable

    # Movie attributes
    ATTRIBUTES = :id, :adult, :backdrop_path, :belongs_to_collection, :budget,
                 :genres, :homepage, :imdb_id, :original_title, :overview,
                 :popularity, :poster_path, :production_companies, :runtime,
                 :production_countries, :release_date, :revenue, :spoken_languages,
                 :status, :tagline, :title, :vote_average, :vote_count

    attr_reader *ATTRIBUTES

    # Public: Get the basic movie information for a specific movie ID.
    #
    # id      - The ID of the movie.
    # options - The hash options used to filter the search (default: {}):
    #           :language - Language of the result data (ISO 639-1 codes)
    #                       (default: en).
    #
    # Examples
    #
    # TMDb::Movie.find(68721)
    # TMDb::Movie.find(68721, language: 'pt')
    def self.find(id, options = {})
      res = get("/movie/#{id}", query: options)
      res.success? ? Movie.new(res) : bad_response(res)
    end

    # Public: Get the alternative titles for a specific movie ID.
    #
    # options - The hash options used to filter the search (default: {}):
    #           :country - Titles for a specific country (ISO 3166-1 code).
    #
    # Examples
    #
    # TMDb::Movie.alternative_titles(68721, country: 'br')
    def self.alternative_titles(id, options = {})
      res = get("/movie/#{id}/alternative_titles", query: options)
      res.success? ? res['titles'] : bad_response(res)
    end

    # Public: Get the cast for a specific movie ID.
    #
    # options - The hash options used to filter the search (default: {}):
    #           :language - Images of a specific language (ISO 639-1 code).
    #
    # Examples
    #
    # TMDb::Movie.cast(68721, language: pt)
    def self.cast(id, options = {})
      res = get("/movie/#{id}/credits", query: options)
      res.success? ? res['cast'] : bad_response(res)
    end

    # Public: Get the crew for a specific movie ID.
    #
    # options - The hash options used to filter the search (default: {}):
    #           :language - Images of a specific language (ISO 639-1 code).
    #
    # Examples
    #
    # TMDb::Movie.crew(68721, language: pt)

    def self.crew(id, options = {})
      res = get("/movie/#{id}/credits", query: options)
      res.success? ? res['crew'] : bad_response(res)
    end

    # Public: Get the images (posters and backdrops) for a specific movie ID.
    #
    # options - The hash options used to filter the search (default: {}):
    #           :language - Images of a specific language (ISO 639-1 code).
    #
    # Examples
    #
    # TMDb::Movie.find(68721).images
    # TMDb::Movie.images(68721, language: 'pt')

    def self.images(id, options = {})
      res = get("/movie/#{id}/images", query: options)
      res.success? ? res : bad_response(res)
    end

    # Public: Get the plot keywords for a specific movie ID.
    #
    # options - The hash options used to filter the search (default: {}):
    #           :language - Images of a specific language (ISO 639-1 code).
    #
    # Examples
    #
    # TMDb::Movie.keywords(68721, language: pt)
    def self.keywords(id, options = {})
      res = get("/movie/#{id}/keywords", query: options)
      res.success? ? res['keywords'] : bad_response(res)
    end

    # Public: Get the trailers for a specific movie ID.
    #
    # options - The hash options used to filter the search (default: {}):
    #           :language - Images of a specific language (ISO 639-1 code).
    #
    # Examples
    #
    # TMDb::Movie.trailers(68721, language: pt)
    def self.trailers(id, options = {})
      res = get("/movie/#{id}/trailers", query: options)
      res.success? ? res : bad_response(res)
    end

    # Public: Get the release date by country for a specific movie ID.
    #
    # Examples
    #
    # TMDb::Movie.releases(68721)
    def self.releases(id)
      res = get("/movie/#{id}/releases")
      res.success? ? res['countries'] : bad_response(res)
    end

    # Public: Get the list of upcoming movies. This list refreshes every day.
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
    def self.upcoming(options = {})
      res = get('/movie/upcoming', query: options)

      if res.success?
        res['results'].map { |movie| Movie.new(movie) }
      else
        bad_response(res)
      end
    end
  end
end
