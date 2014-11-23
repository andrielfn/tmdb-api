require 'spec_helper'

describe TMDb::Searchable do
  describe ".search" do
    it "searches movies given only the movie name" do
      stub_get('/search/movie').with(query: { query: 'The Lord of the Rings' })
        .to_return(json_response('searchable/search_movie_by_name.json'))

      movies = TMDb::Movie.search("The Lord of the Rings")

      expect(movies.count).to eq(7)

      expect(movies.first.adult).to eq(false)
      expect(movies.first.backdrop_path).to eq("/pIUvQ9Ed35wlWhY2oU6OmwEsmzG.jpg")
      expect(movies.first.id).to eq(120)
      expect(movies.first.original_title).to eq("The Lord of the Rings: The Fellowship of the Ring")
      expect(movies.first.release_date).to eq("2001-12-19")
      expect(movies.first.poster_path).to eq("/9HG6pINW1KoFTAKY3LdybkoOKAm.jpg")
      expect(movies.first.popularity).to eq(10.895025450078979)
      expect(movies.first.title).to eq("The Lord of the Rings: The Fellowship of the Ring")
      expect(movies.first.vote_average).to eq(8.3)
      expect(movies.first.vote_count).to eq(187)
    end

    it "searches for a person given a name" do
      stub_get('/search/person').with(query: { query: 'Peter Jackson' })
        .to_return(json_response('searchable/search_person_by_name.json'))

      people = TMDb::Person.search('Peter Jackson')

      expect(people.count).to eq(3)

      expect(people.first.adult).to eq(false)
      expect(people.first.id).to eq(108)
      expect(people.first.name).to eq("Peter Jackson")
      expect(people.first.popularity).to eq(3.411923015718)
      expect(people.first.profile_path).to eq("/8MN8C1w1wuEHMxdvDqHP5bDFMh.jpg")
    end

    it 'raises with a bad request' do
      stub_get('/search/movie').with(query: { query: 'Iron Man' })
        .to_return(status: 404)

      expect { TMDb::Movie.search("Iron Man") }.to raise_error ArgumentError
    end
  end
end

