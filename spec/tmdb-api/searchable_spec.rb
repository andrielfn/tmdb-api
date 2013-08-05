require 'spec_helper'

describe TMDb::Searchable do
  describe ".search" do
    it "searches movies given only the movie name" do
      stub_get('/search/movie').with(query: { query: 'The Lord of the Rings' })
        .to_return(json_response('search_movie_by_name.json'))

      movies = TMDb::Movie.search("The Lord of the Rings")

      expect(movies).to have(7).items

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

    it "searches movies given movie name and year" do
      stub_get('/search/movie').with(query: { query: 'Matrix', year: 1999 })
        .to_return(json_response('search_movie_by_name_and_year.json'))

      movies = TMDb::Movie.search('Matrix', year: 1999)

      expect(movies).to have(1).item

      expect(movies.first.adult).to eq(false)
      expect(movies.first.backdrop_path).to eq("/gM3KKiN80qbJgKHjPnmAfwxSicG.jpg")
      expect(movies.first.id).to eq(603)
      expect(movies.first.original_title).to eq("The Matrix")
      expect(movies.first.release_date).to eq("1999-03-30")
      expect(movies.first.poster_path).to eq("/gynBNzwyaHKtXqlEKKLioNkjKgN.jpg")
      expect(movies.first.popularity).to eq(7.94015698023987)
      expect(movies.first.title).to eq("The Matrix")
      expect(movies.first.vote_average).to eq(8.5)
      expect(movies.first.vote_count).to eq(364)
    end

    it "searches movies given movie name and page number" do
      stub_get('/search/movie').with(query: { query: 'Fight', page: 2 })
        .to_return(json_response('search_movie_by_name_and_page.json'))

      movies = TMDb::Movie.search('Fight', page: 2)

      expect(movies).to have(20).items

      expect(movies.first.adult).to eq(false)
      expect(movies.first.backdrop_path).to eq("/sNqj5kwBRxz91xJWFxgYRsdXuyp.jpg")
      expect(movies.first.id).to eq(119199)
      expect(movies.first.original_title).to eq("Arena of the Street Fighter")
      expect(movies.first.release_date).to eq("2012-07-26")
      expect(movies.first.poster_path).to eq("/8OFWwM7MeqZDXsLsZm4q6vLU1zB.jpg")
      expect(movies.first.popularity).to eq(0.4)
      expect(movies.first.title).to eq("Arena of the Street Fighter")
      expect(movies.first.vote_average).to eq(0.5)
      expect(movies.first.vote_count).to eq(1)
    end

    it "searches movies given movie name and adult filter" do
      stub_get('/search/movie').with(query: { query: 'Gang Bang 5', include_adult: true.to_s })
        .to_return(json_response('search_movie_by_name_and_adult_filter.json'))

      movies = TMDb::Movie.search('Gang Bang 5', include_adult: true.to_s)

      expect(movies).to have(4).items

      expect(movies.first.adult).to eq(true)
      expect(movies.first.backdrop_path).to eq(nil)
      expect(movies.first.id).to eq(68025)
      expect(movies.first.original_title).to eq("Gang Bang 5")
      expect(movies.first.release_date).to eq(nil)
      expect(movies.first.poster_path).to eq("/j2rfswcwXNSzYKORb5tJQO7u4UY.jpg")
      expect(movies.first.popularity).to eq(0.4)
      expect(movies.first.title).to eq("Gang Bang 5")
      expect(movies.first.vote_average).to eq(0)
      expect(movies.first.vote_count).to eq(0)
    end

    it "returns an empty array when no movies found" do
      stub_get('/search/movie').with(query: { query: 'Inexistent Movie' })
        .to_return(json_response('no_results.json'))

      movies = TMDb::Movie.search('Inexistent Movie')

      expect(movies).to match_array([])
    end

    it 'raises with a bad request' do
      stub_get('/search/movie').with(query: { query: 'Iron Man' })
        .to_return(status: 404)

      expect { TMDb::Movie.search("Iron Man") }.to raise_error ArgumentError
    end
  end
end

