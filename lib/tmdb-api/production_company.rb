module TMDb
  class ProductionCompany < Base

    # Genre attributes
    ATTRIBUTES = :id, :name

    attr_reader *ATTRIBUTES
  end
end
