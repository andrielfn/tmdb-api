module TMDb
  class Changes < Base
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
      res.success? ? res : bad_response(res)
    end
  end
end
