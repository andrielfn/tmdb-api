module TMDb
  class SpokenLanguage < Base
    attr_reader :iso_639_1, :name

    # Public: alias for the iso_639_1 attribute.
    def code
      @iso_639_1
    end
  end
end
