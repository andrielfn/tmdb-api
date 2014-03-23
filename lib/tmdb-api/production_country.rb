module TMDb
  class ProductionCountry < Base
    attr_reader :iso_3166_1, :name

    # Public: alias for the iso_3166_1 attribute.
    def code
      @iso_3166_1
    end
  end
end
