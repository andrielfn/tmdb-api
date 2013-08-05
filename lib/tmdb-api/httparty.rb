module HTTParty
  class Request
    alias_method :original_query_string, :query_string

    def query_string(uri)
      options[:default_params].merge!(api_key: TMDb.api_key)
      original_query_string(uri)
    end
  end
end
