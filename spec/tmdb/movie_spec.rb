require "spec_helper"

describe TMDb::Movie do

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
  end

  describe ".find" do
    it "find a movie given your ID" do
      stub_get('/movie/24').to_return(json_response('find_movie_by_id.json'))

      movie = TMDb::Movie.find(24)

      expect(movie.adult).to eq(false)
      expect(movie.backdrop_path).to eq("/hSaH9tt67bozo9K50sbH0s4YjEc.jpg")
      expect(movie.belongs_to_collection).to eq(nil)
      expect(movie.budget).to eq(3300000)
      expect(movie.genres).to eq([
        {
          "id" => 28,
          "name" => "Action"
        },
        {
          "id" => 80,
          "name" => "Crime"
        },
        {
          "id" => 18,
          "name" => "Drama"
        },
        {
          "id" => 10769,
          "name" => "Foreign"
        }
      ])
      expect(movie.homepage).to eq('http://cidadededeus.globo.com/')
      expect(movie.id).to eq(598)
      expect(movie.imdb_id).to eq('tt0317248')
      expect(movie.original_title).to eq("Cidade de Deus")
      expect(movie.overview).to eq("City of God depicts the raw violence in the ghettos of Rio de Janeiro. In the 1970’s that kids are carrying guns and joining gangs when they should be playing hide-and-seek.")
      expect(movie.popularity).to eq(1.3497251049225558)
      expect(movie.poster_path).to eq("/mwDnSQR1CkxuDjSKfgiNT0sIOjM.jpg")
      expect(movie.production_companies).to eq([
        {
          "name" => "O2 Filmes",
          "id" => 345
        },
        {
          "name" => "VideoFilmes",
          "id" => 346
        },
        {
          "name" => "Globo filmes",
          "id" => 10954
        },
        {
          "name" => "Lumiere",
          "id" => 11444
        },
        {
          "name" => "Wild Bunch",
          "id" => 856
        },
        {
          "name" => "Hank Levine Film",
          "id" => 11445
        },
        {
          "name" => "Lereby Productions",
          "id" => 11446
        }
      ])
      expect(movie.production_countries).to eq([
        {
          "iso_3166_1" => "BR",
          "name" => "Brazil"
        },
        {
          "iso_3166_1" => "FR",
          "name" => "France"
        }
      ])
      expect(movie.release_date).to eq("2002-08-31")
      expect(movie.revenue).to eq(27387381)
      expect(movie.runtime).to eq(130)
      expect(movie.spoken_languages).to eq([
        {
          "iso_639_1" => "pt",
          "name" => "Português"
        }
      ])
      expect(movie.status).to eq("Released")
      expect(movie.tagline).to eq("If you run you're dead...if you stay, you're dead again. Period.")
      expect(movie.title).to eq("City of God")
      expect(movie.vote_average).to eq(8.2)
      expect(movie.vote_count).to eq(52)
    end

    it "find a movie given your ID and language" do
      stub_get('/movie/550').with(query: { language: 'pt' })
        .to_return(json_response('find_movie_by_id_and_language.json'))

      movie = TMDb::Movie.find(550, language: 'pt')

      expect(movie.adult).to eq(false)
      expect(movie.backdrop_path).to eq("/kkS8PKa8c134vXsj2fQkNqOaCXU.jpg")
      expect(movie.belongs_to_collection).to eq({
        "id" => 2883,
        "name" => "Kill Bill Collection",
        "poster_path" => "/tf1nUtw3LJGUGv1EFFi23iz6ngr.jpg",
        "backdrop_path" => "/oCLKNACMNrEf4T1EP6BpMXDl5m1.jpg"
      })
      expect(movie.budget).to eq(55000000)
      expect(movie.genres).to eq([
        {
          "id" => 28,
          "name" => "Ação"
        },
        {
          "id" => 80,
          "name" => "Crime"
        },
        {
          "id" => 53,
          "name" => "Thriller"
        }
      ])
      expect(movie.homepage).to eq('')
      expect(movie.id).to eq(24)
      expect(movie.imdb_id).to eq('tt0266697')
      expect(movie.original_title).to eq("Kill Bill: Vol. 1")
      expect(movie.overview).to eq("Kill Bill presta uma grande homenagem aos filmes de Kung-fu das décadas de 60 e 70, seus atores e estilos. Dirigido com exímia presteza, a obra foi delicadamente produzida o que dá ao expectador um deleite frente às diversas mudanças de sensibilidade do filme, cenas em preto e branco, seqüências, sombras, ângulos de câmera e intertextualidade com outras mídias como o trecho do filme feito em anime e a sensacional trilha sonora que se tornou um dos deliciosos hábitos viciantes dos filmes de Tarantino. O primeiro volume do filme narra o início da vingança da ex-assassina Black Mamba (cujo nome real só nos é revelado ao final do segundo filme). Ao acordar do coma, Black Mamba percebe que foi a única sobrevivente do extermínio ocorrido no dia de seu casamento e que levara as vidas de todos a quem amava, inclusive do filho que levava no ventre. Ela começa então uma caçada impiedosa aos assassinos, seus ex-companheiros do esquadrão de assassinato Deadly Viper.")
      expect(movie.popularity).to eq(2.884757761614897)
      expect(movie.poster_path).to eq("/viscNSLi1rDyMuTytUojf0G2DIy.jpg")
      expect(movie.production_companies).to eq([
        {
          "name" => "Miramax Films",
          "id" => 14
        },
        {
          "name" => "A Band Apart",
          "id" => 59
        }
      ])
      expect(movie.production_countries).to eq([
        {
          "iso_3166_1" => "JP",
          "name" => "Japan"
        },
        {
          "iso_3166_1" => "US",
          "name" => "United States of America"
        }
      ])
      expect(movie.release_date).to eq("2003-10-09")
      expect(movie.revenue).to eq(180949000)
      expect(movie.runtime).to eq(111)
      expect(movie.spoken_languages).to eq([
        {
          "iso_639_1" => "en",
          "name" => "English"
        }
      ])
      expect(movie.status).to eq("Released")
      expect(movie.tagline).to eq("")
      expect(movie.title).to eq("Kill Bill - Volume 1")
      expect(movie.vote_average).to eq(7.6)
      expect(movie.vote_count).to eq(92)
    end

    it 'raises error with id not found' do
      stub_get('/movie/1234').to_return(json_response('invalid_id.json', 404))
      expect { TMDb::Movie.find(1234) }.to raise_error(ArgumentError)
    end
  end

  describe "#alternative_titles" do
    it "returns the alternative titles for a specific movie" do
      stub_get('/movie/598').to_return(json_response('find_movie_by_id.json'))
      stub_get('/movie/598/alternative_titles')
        .to_return(json_response('alternative_titles.json'))

      alternative_titles = TMDb::Movie.alternative_titles(598)

      expect(alternative_titles).to match_array([
        {
          "iso_3166_1" => "RU",
          "title" => "Город бога"
        },
        {
          "iso_3166_1" => "IT",
          "title" => "City of God - La città di Dio"
        },
        {
          "iso_3166_1" => "BR",
          "title" => "Cidade de Deus"
        },
        {
          "iso_3166_1" => "FR",
          "title" => "La cité de Dieu"
        },
        {
          "iso_3166_1" => "DE",
          "title" => "City of God"
        },
        {
          "iso_3166_1" => "CN",
          "title" => "上帝之城"
        },
        {
          "iso_3166_1" => "HK",
          "title" => "无主之城"
        },
        {
          "iso_3166_1" => "US",
          "title" => "City of God"
        },
        {
          "iso_3166_1" => "TW",
          "title" => "無法無天"
        }
      ])
    end

    it "returns the alternative titles for a specific movie and a specific country" do
      stub_get('/movie/598').to_return(json_response('find_movie_by_id.json'))
      stub_get('/movie/598/alternative_titles').with(query: { country: 'br' })
        .to_return(json_response('alternative_titles_by_country.json'))

      alternative_titles = TMDb::Movie.alternative_titles(598, country: 'br')

      expect(alternative_titles).to match_array([
        {
          "iso_3166_1" => "BR",
          "title" => "Cidade de Deus"
        }
      ])
    end
  end

  describe '#images' do
    it 'returns the images (posters and backdrops) for a specific movie ID' do
      stub_get('/movie/598').to_return(json_response('find_movie_by_id.json'))
      stub_get('/movie/598/images')
        .to_return(json_response('movie_images.json'))

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

    it 'returns the images (posters and backdrops) for a specific movie ID and a specific language' do
      stub_get('/movie/598').to_return(json_response('find_movie_by_id.json'))
      stub_get('/movie/598/images')
        .to_return(json_response('movie_images_by_language.json'))

      images = TMDb::Movie.images(598)

      expect(images['backdrops']).to have(0).items
      expect(images['posters']).to have(4).items

      expect(images['posters'].first).to eq(
        {
          "file_path" => "/c9qkycW5DFsycCmuPDPnWvpmCJ5.jpg",
          "width" => 748,
          "height" => 1102,
          "iso_639_1" => "pt",
          "aspect_ratio" => 0.68,
          "vote_average" => 5.27891156462585,
          "vote_count" => 7
        }
      )
    end
  end

  describe '#keywords' do
    it 'return the plot keywords for a specific movie id' do
      stub_get('/movie/598').to_return(json_response('find_movie_by_id.json'))
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
  end

  describe '#releases' do
    it 'returns the release date by country for a specific movie id' do
      stub_get('/movie/598').to_return(json_response('find_movie_by_id.json'))
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
  end
end
