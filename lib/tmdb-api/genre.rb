module TMDb
  class Genre < Base

    # Genre attributes
    ATTRIBUTES = :id, :name

    attr_reader *ATTRIBUTES
  end
end
