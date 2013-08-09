module TMDb
  class Person < Base
    extend Searchable

    # Person attributes
    ATTRIBUTES = :id, :adult, :also_known_as, :biography, :birthday, :deathday,
                 :homepage, :name, :place_of_birth, :profile_path, :popularity

    attr_reader *ATTRIBUTES

    # Public: Get the basic person information for a specific person ID.
    #
    # id      - The ID of the person.
    # options - The hash options used to filter the search (default: {}):
    #           More information about the options, check the api documentation
    #
    # Examples
    #
    # TMDb::Person.find(138)
    def self.find(id, options = {})
      res = get("/person/#{id}", query: options)
      res.success? ? Person.new(res) : bad_response(res)
    end

    # Public: Get the images for a specific person ID.
    #
    # id  - The person's ID
    #
    # Examples
    #
    # TMDb::Person.images(138)
    def self.images(id)
      res = get("/person/#{id}/images")
      res.success? ? res : bad_response(res)
    end

    # Public: Get a list of popular people.
    #
    # options - The hash options used to filter the search (default: {}):
    #           :page - List's page.
    #
    # Examples
    #
    # TMDb::Person.popular
    # TMDb::Person.popular(page: 4)
    def self.popular(options = {})
      res = get('/person/popular', query: options)

      if res.success?
        res['results'].map { |person| Person.new(person) }
      else
        bad_response(res)
      end
    end
  end
end