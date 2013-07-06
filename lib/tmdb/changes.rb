module TMDb
  class Changes
    # Get a list of movie ids that have been edited. By default we show the
    # last 24 hours and only 100 items per page. The maximum number of days
    # that can be returned in a single request is 14.
    #
    # options - The hash options used to filter the search (default: {}):
    #           :page - Page.
    #           :start_date - Start date (YYYY-MM-DD).
    #           :end_date - End date (YYYY-MM-DD).
    #
    # Examples
    #
    # TMDb::Movie.find(24)
    #
    # TMDb::Movie.find(32123, language: 'pt')
    #
    def self.movies(options = {})
      Fetcher::get('/movie/changes', options)
    end
  end
end
