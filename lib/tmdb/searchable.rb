require "cgi"

module TMDb
  module Searchable
    # Search movies.
    #
    # query   - Query string that will be matched with the movie name.
    # options - The hash options used to filter the search (default: {}):
    #           :page - The current page of results.
    #           :language - Language of the result data (ISO 639-1 codes) (default: en).
    #           :include_adult - Toggle the inclusion of adult titles. Expected value is: true or false.
    #           :year - Filter results to only include this value.
    #
    # Examples
    #
    # TMDb::Movie.search('Iron Man')
    #
    # TMDb::Movie.search('The Matrix', year: 1999)
    #
    # TMDb::Movie.search('Forret Gump', language: 'pt', year: 1994)
    def search(query, options = {})
      # require "pry"; binding.pry
      options.merge!(query: query)
      result = Fetch.get("/search/#{resource}", options)
      result['results'].map { |attributes| new(attributes) }
    end

    # Removes the module part from the expression in the string.
    def resource
      name.split('::').last.downcase || ''
    end
  end
end
