require 'spec_helper'

describe TMDb::Movie do
  describe '#releases' do
    it 'returns the release for a specific movie' do
      stub_get('/movie/598/releases').to_return(json_response('movie_releases.json'))

      releases = TMDb::Movie.releases(598)

      expect(releases).to have(6).items

      expect(releases).to match_array([
        {
          "iso_3166_1" => "RU",
          "certification" => "",
          "release_date" => "2002-02-05"
        },
        {
          "iso_3166_1" => "US",
          "certification" => "R",
          "release_date" => "2002-08-31"
        },
        {
          "iso_3166_1" => "BR",
          "certification" => "",
          "release_date" => "2002-08-30"
        },
        {
          "iso_3166_1" => "CA",
          "certification" => "",
          "release_date" => "2002-09-06"
        },
        {
          "iso_3166_1" => "GB",
          "certification" => "18",
          "release_date" => "2002-11-08"
        },
        {
          "iso_3166_1" => "DE",
          "certification" => "16",
          "release_date" => "2003-05-08"
        }
      ])
    end

    it 'raises with a bad request' do
      stub_get('/movie/598/releases').to_return(status: 404)

      expect { TMDb::Movie.releases(598) }.to raise_error ArgumentError
    end
  end
end
