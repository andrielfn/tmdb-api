module TMDb
  class ProductionCountry < Base

    # Genre attributes
    ATTRIBUTES = :iso_3166_1, :name

    attr_reader *ATTRIBUTES

    # Public: alias for the iso_3166_1 attribute.
    def code
      @iso_3166_1
    end
  end
end
