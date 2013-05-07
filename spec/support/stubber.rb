def stub_get(url, options = {}, key = true)
  stub_request(:get, tmdb_url(url, key))
end

# Retuns absolute path of fixtures directory.
def fixture_path
  File.expand_path('../../fixtures', __FILE__)
end

# Returns the fixture File object given a file.
def fixture(file)
  File.new(fixture_path + '/' + file)
end

# Set the stub return to be JSON.
def json_response(file, status = 200)
  options = {
    :body => fixture(file),
    :headers => {
      :content_type => 'application/json; charset=utf-8'
    },
    :status => status
  }
end

# Returns the entire URL of TMDb API.
def tmdb_url(url, key)
  if key
    "http://api.themoviedb.org/3#{url}?api_key=#{TMDb.api_key}"
  else
    "http://api.themoviedb.org/3#{url}?api_key="
  end
end
