module TMDb
  class Base
    include HTTParty
    base_uri 'http://api.themoviedb.org/3/'
    headers 'Accept' => 'application/json'
    headers 'Content-Type'  => 'application/json'
    format :json

    # Internal: Raises an exception depending on the type of
    # the response.
    #
    # response - Result of a request.
    #
    # Raises an exception.
    def self.bad_response(response)
      if response.class == HTTParty::Response
        raise ArgumentError, response['status_message']
      end
      raise StandardError, 'Unkown error'
    end

    # Internal: creates a new TMDb::Base object.
    #
    # attributes - Attributes fetched from the API.
    def initialize(attributes = {})
      load(attributes)
    end

    private

    # Internal: Sets the attributes to the object.
    #
    # attributes - A hash containing the keys and values to be
    #              set in the object.
    #
    # Returns nothing
    def load(attributes)
      attributes.each do |key, value|
        self.instance_variable_set("@#{key}", value)
      end
    end
  end
end
