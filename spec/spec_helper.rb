require 'tmdb-api'
require 'rspec'
require 'webmock/rspec'

# Load all support files
Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each {|r| require r}

# Fake API Key
TMDb.api_key = '56565958363476674e5e63643c787867'

RSpec.configure do |config|
  config.expect_with :rspec do |c|

    # Set RSpec to accept only the new syntax.
    # http://myronmars.to/n/dev-blog/2012/06/rspecs-new-expectation-syntax
    c.syntax = :expect
  end
end

