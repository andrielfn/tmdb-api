module TMDb
  class Changes < Base
    ATTRIBUTES = :changes, :page, :total_pages, :total_results

    attr_reader *ATTRIBUTES

    # Public: Get a list of movie ids that have been edited. By default we
    # show the last 24 hours and only 100 items per page. The maximum number
    # of days that can be returned in a single request is 14.
    #
    # options - The hash options used to filter the search (default: {}).
    #           :page - Page. Minimum 1, maximum 1000.
    #           :start_date - Start date (YYYY-MM-DD).
    #           :end_date - End date (YYYY-MM-DD).
    #
    # Examples
    #
    #   TMDb::Changes.movies
    #   TMDb::Changes.movies(page: 1, start_date: '2013-03-22')
    def self.movies(options = {})
      res = get('/movie/changes', query: options)
      res.success? ? Changes.new(res) : bad_response(res)
    end

    private

    # Internal: sets the fetched result to the instance variables.
    #
    # attributes - Returned attributes from the API.
    def set_attributes(attributes)
      @changes = results_ids(attributes['results'])
      @page = attributes['page']
      @total_pages = attributes['total_pages']
      @total_results = attributes['total_results']
    end

    # Internal: Extract only the IDs from the result.
    #
    # changes - The `results` key returned from the API.
    def results_ids(changes)
      changes.map do |item|
        item['id']
      end
    end
  end
end
