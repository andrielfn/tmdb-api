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
  end

  describe ".find" do
    it "find a movie given your ID" do
      stub_get('/movie/550').to_return(json_response('find_movie_by_id.json'))

      movie = TMDb::Movie.find(550)

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
          "name" => "Action"
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
      expect(movie.overview).to eq("An assassin is shot at the altar by her ruthless employer, Bill, and other members of their assassination circle. But The Bride lives to plot her vengeance. Setting out for some payback, she makes a death list and hunts down those who wronged her, saving Bill for last.")
      expect(movie.popularity).to eq(3.61585920538299)
      expect(movie.poster_path).to eq("/9O50TVszkz0dcP5g6Ej33UhR7vw.jpg")
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
      expect(movie.tagline).to eq("Go for the kill.")
      expect(movie.title).to eq("Kill Bill: Vol. 1")
      expect(movie.vote_average).to eq(7.6)
      expect(movie.vote_count).to eq(92)
    end

    it "find a movie given your ID and language" do
      stub_get('/movie/550').with(query: { language: 'pt' }).to_return(json_response('find_movie_by_id_and_language.json'))

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
  end
end
