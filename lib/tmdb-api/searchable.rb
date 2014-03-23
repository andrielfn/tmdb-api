module TMDb
  module Searchable
    # Public: Search resources like a movie, a person, a collection and so on.
    #
    ## For a movie
    # query   - Query string that will be matched with the movie name.
    # options - The hash options used to filter the search (default: {}):
    #           :page - The current page of results.
    #           :language - Language of the result data (ISO 639-1 codes) (default: en).
    #           :include_adult - Toggle the inclusion of adult titles. Expected value is: true or false.
    #           :year - Filter results to only include this value.
    #
    # Examples
    #
    ## For a movie
    #   TMDb::Movie.search('Iron Man')
    #   TMDb::Movie.search('The Matrix', year: 1999)
    #   TMDb::Movie.search('Forret Gump', language: 'pt', year: 1994)
    #
    ## For a person
    #   TMDb::Person.search('Peter Jackson')
    #   TMDb::Person.search('Paul', page: 4)
    def search(query, options = {})
      options.merge!(query: query)
      res = get("/search/#{resource}", query: options)
      if res.success?
        res['results'].map { |attributes| new(attributes) }
      else
        bad_response(res)
      end
    end

    private

    def resource
      name.split('::').last.downcase
    end
  end
end
