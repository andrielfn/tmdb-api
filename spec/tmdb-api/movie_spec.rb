# coding: utf-8
require 'spec_helper'

describe TMDb::Movie do
  describe '.find' do
    before do
      stub_get('/movie/24').to_return(json_response('movie/find.json'))
    end

    let(:movie) { TMDb::Movie.find(24) }

    it 'returns the "adult" attribute' do
      expect(movie.adult).to eq(false)
    end

    it 'returns the "backdrop_path" attribute' do
      expect(movie.backdrop_path).to eq('/hSaH9tt67bozo9K50sbH0s4YjEc.jpg')
    end

    it 'returns the "belongs_to_collection" attribute' do
      expect(movie.belongs_to_collection).to eq(nil)
    end

    it 'returns the "budget" attribute' do
      expect(movie.budget).to eq(3300000)
    end

    it 'returns movie genres as objects' do
      expect(movie.genres).to have(4).genres

      first_genre = movie.genres.first
      expect(first_genre.id).to eql(28)
      expect(first_genre.name).to eql('Action')
    end

    it 'returns the "homepage" attribute' do
      expect(movie.homepage).to eq('http://cidadededeus.globo.com/')
    end

    it 'returns the "id" attribute' do
      expect(movie.id).to eq(598)
    end

    it 'returns the "imdb_id" attribute' do
      expect(movie.imdb_id).to eq('tt0317248')
    end

    it 'returns the "original_title" attribute' do
      expect(movie.original_title).to eq('Cidade de Deus')
    end

    it 'returns the "overview" attribute' do
      expect(movie.overview).to eq(
        'City of God depicts the raw violence in the ghettos of Rio de Janeiro.'
      )
    end

    it 'returns the "popularity" attribute' do
      expect(movie.popularity).to eq(1.3497251049225558)
    end

    it 'returns the "poster_path" attribute' do
      expect(movie.poster_path).to eq('/mwDnSQR1CkxuDjSKfgiNT0sIOjM.jpg')
    end

    it 'returns movie production companies as objects' do
      expect(movie.production_companies).to have(7).production_companies

      first_company = movie.production_companies.first
      expect(first_company.id).to eql(345)
      expect(first_company.name).to eql('O2 Filmes')
    end

    it 'returns movie production countries as objects' do
      expect(movie.production_countries).to have(2).production_countries

      first_country = movie.production_countries.first
      expect(first_country.iso_3166_1).to eql('BR')
      expect(first_country.code).to eql('BR')
      expect(first_country.name).to eql('Brazil')
    end

    it 'returns the "release_date" attribute' do
      expect(movie.release_date).to eq('2002-08-31')
    end

    it 'returns the "revenue" attribute' do
      expect(movie.revenue).to eq(27387381)
    end

    it 'returns the "runtime" attribute' do
      expect(movie.runtime).to eq(130)
    end

    it 'returns movie spoken languages as objects' do
      expect(movie.spoken_languages).to have(1).spoken_languages

      first_country = movie.spoken_languages.first
      expect(first_country.iso_639_1).to eql('pt')
      expect(first_country.code).to eql('pt')
      expect(first_country.name).to eql('Português')
    end

    it 'returns the "status" attribute' do
      expect(movie.status).to eq('Released')
    end

    it 'returns the "tagline" attribute' do
      expect(movie.tagline).to eq('If you run you\'re dead...if you stay, you\'re dead again. Period.')
    end

    it 'returns the "title" attribute' do
      expect(movie.title).to eq('City of God')
    end

    it 'returns the "vote_average" attribute' do
      expect(movie.vote_average).to eq(8.2)
    end

    it 'returns the "vote_count" attribute' do
      expect(movie.vote_count).to eq(52)
    end

    it 'raises with a bad request' do
      stub_get('/movie/1234').to_return(status: 404)

      expect { TMDb::Movie.find(1234) }.to raise_error(ArgumentError)
    end
  end

  describe '.alternative_titles' do
    it 'returns the alternative titles for a specific movie' do
      stub_get('/movie/598/alternative_titles')
        .to_return(json_response('movie/alternative_titles.json'))

      alternative_titles = TMDb::Movie.alternative_titles(598)

      expect(alternative_titles).to match_array([
        {
          'iso_3166_1' => 'RU',
          'title' => 'Город бога'
        },
        {
          'iso_3166_1' => 'IT',
          'title' => 'City of God - La città di Dio'
        },
        {
          'iso_3166_1' => 'BR',
          'title' => 'Cidade de Deus'
        },
        {
          'iso_3166_1' => 'FR',
          'title' => 'La cité de Dieu'
        },
        {
          'iso_3166_1' => 'DE',
          'title' => 'City of God'
        },
        {
          'iso_3166_1' => 'CN',
          'title' => '上帝之城'
        },
        {
          'iso_3166_1' => 'HK',
          'title' => '无主之城'
        },
        {
          'iso_3166_1' => 'US',
          'title' => 'City of God'
        },
        {
          'iso_3166_1' => 'TW',
          'title' => '無法無天'
        }
      ])
    end

    it 'raises with a bad request' do
      stub_get('/movie/invalid-id/alternative_titles').to_return(status: 404)

      expect { TMDb::Movie.alternative_titles('invalid-id') }
        .to raise_error ArgumentError
    end
  end

  describe '.images' do
    it 'returns the images (posters and backdrops) for a specific movie ID' do
      stub_get('/movie/598/images')
        .to_return(json_response('movie/images.json'))

      images = TMDb::Movie.images(598)

      expect(images['backdrops']).to have(7).items
      expect(images['posters']).to have(16).items

      expect(images['backdrops'].first).to eq(
        {
          "file_path" => "/hSaH9tt67bozo9K50sbH0s4YjEc.jpg",
          "width" => 1532,
          "height" => 862,
          "iso_639_1" => nil,
          "aspect_ratio" => 1.78,
          "vote_average" => 5.4421768707483,
          "vote_count" => 7
        }
      )

      expect(images['posters'].first).to eq(
        {
          "file_path" => "/mwDnSQR1CkxuDjSKfgiNT0sIOjM.jpg",
          "width" => 1000,
          "height" => 1500,
          "iso_639_1" => "en",
          "aspect_ratio" => 0.67,
          "vote_average" => 5.384615384615385,
          "vote_count" => 2
        }
      )
    end

    it 'raises with a bad request' do
      stub_get('/movie/598/images').to_return(status: 404)

      expect { TMDb::Movie.images(598) }.to raise_error ArgumentError
    end
  end

  describe '.keywords' do
    it 'return the plot keywords for a specific movie id' do
      stub_get('/movie/598/keywords').to_return(json_response('movie/keywords.json'))

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

  describe '.releases' do
    it 'returns the release for a specific movie' do
      stub_get('/movie/598/releases').to_return(json_response('movie/releases.json'))

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

  describe '.upcoming' do
    it 'returns the upcoming movies' do
      stub_get('/movie/upcoming').to_return(json_response('movie/upcoming.json'))

      upcoming = TMDb::Movie.upcoming

      expect(upcoming).to have(20).movies
      expect(upcoming.first.id).to eql(68726)
      expect(upcoming.first.title).to eql('Pacific Rim')
    end

    it 'raises with a bad request' do
      stub_get('/movie/upcoming').to_return(status: 404)

      expect { TMDb::Movie.upcoming }.to raise_error ArgumentError
    end
  end
end
