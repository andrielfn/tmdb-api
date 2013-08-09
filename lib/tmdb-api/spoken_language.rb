module TMDb
  class SpokenLanguage < Base

    # Spoken language attributes
    ATTRIBUTES = :iso_639_1, :name

    attr_reader *ATTRIBUTES

    # Public: alias for the iso_639_1 attribute.
    def code
      @iso_639_1
    end
  end
end
