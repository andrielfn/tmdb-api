module TMDb
  class Person < Base
    extend Searchable

    # Person attributes
    ATTRIBUTES = :id, :adult, :also_known_as, :biography, :birthday, :deathday,
                 :homepage, :name, :place_of_birth, :profile_path, :popularity

    attr_reader *ATTRIBUTES

    def self.find(id, options = {})
      res = get("/person/#{id}", query: options)
      res.success? ? Person.new(res) : bad_response(res)
    end

    def self.images(id, options = {})
      res = get("/person/#{id}/images", query: options)
      res.success? ? res : bad_response(res)
    end
  end
end