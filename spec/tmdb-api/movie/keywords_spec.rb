require 'spec_helper'

describe TMDb::Movie do
  describe '#keywords' do
    it 'return the plot keywords for a specific movie id' do
      stub_get('/movie/598/keywords').to_return(json_response('movie_keywords.json'))

      keywords = TMDb::Movie.keywords(598)

      expect(keywords).to have(7).items

      expect(keywords).to match_array([
        {
          "id" => 542,
          "name" => "street gang"
        },
        {
          "id" => 983,
          "name" => "brazilian"
        },
        {
          "id" => 1228,
          "name" => "seventies"
        },
        {
          "id" => 1525,
          "name" => "puberty"
        },
        {
          "id" => 1687,
          "name" => "80s"
        },
        {
          "id" => 2394,
          "name" => "ghetto"
        },
        {
          "id" => 2987,
          "name" => "gang war"
        }
      ])
    end

    it 'raises with a bad request' do
      stub_get('/movie/598/keywords').to_return(status: 404)

      expect { TMDb::Movie.keywords(598) }.to raise_error ArgumentError
    end
  end
end
