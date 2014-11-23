require 'active_support/core_ext/string'

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
      set_attributes(attributes)
    end

    private

    # Internal: Sets the attributes to the object.
    #
    # attributes - A hash containing the keys and values to be
    #              set in the object.
    #
    # Returns nothing
    def set_attributes(attributes)
      attributes.each do |key, value|
        if candidate_to_object?(value)
          next unless TMDb.const_defined?(key.classify)
          value = build_objects(key, value)
        end
        self.instance_variable_set("@#{key}", value)
      end
    end

    # Internal: Verifies if the value is an array of hashs.
    #
    # value - value to be evaluated
    #
    # Returns true or false
    def candidate_to_object?(value)
      value.is_a?(Array) && !value.empty? && value.all? { |h| h.is_a?(Hash) }
    end

    # Internal: Builds objects for the nested resources from API.
    #
    # key    - attribute related to the object (ex: genres, spoken_languages).
    # values - values of the attribute.
    #
    # Returns an array of objects
    def build_objects(key, values)
      klass = TMDb.const_get(key.classify)
      values.map do |attr|
        klass.new(attr)
      end
    end
  end
end
