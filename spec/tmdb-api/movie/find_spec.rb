require 'spec_helper'

describe TMDb::Movie do
  describe '.find' do
    it 'find a movie given your ID' do
      stub_get('/movie/24').to_return(json_response('find_movie_by_id.json'))

      movie = TMDb::Movie.find(24)

      expect(movie.adult).to eq(false)
      expect(movie.backdrop_path).to eq('/hSaH9tt67bozo9K50sbH0s4YjEc.jpg')
      expect(movie.belongs_to_collection).to eq(nil)
      expect(movie.budget).to eq(3300000)
      expect(movie.genres).to eq([
        {
          'id' => 28,
          'name' => 'Action'
        },
        {
          'id' => 80,
          'name' => 'Crime'
        },
        {
          'id' => 18,
          'name' => 'Drama'
        },
        {
          'id' => 10769,
          'name' => 'Foreign'
        }
      ])
      expect(movie.homepage).to eq('http://cidadededeus.globo.com/')
      expect(movie.id).to eq(598)
      expect(movie.imdb_id).to eq('tt0317248')
      expect(movie.original_title).to eq('Cidade de Deus')
      expect(movie.overview).to eq('City of God depicts the raw violence in the ghettos of Rio de Janeiro. In the 1970’s that kids are carrying guns and joining gangs when they should be playing hide-and-seek.')
      expect(movie.popularity).to eq(1.3497251049225558)
      expect(movie.poster_path).to eq('/mwDnSQR1CkxuDjSKfgiNT0sIOjM.jpg')
      expect(movie.production_companies).to eq([
        {
          'name' => 'O2 Filmes',
          'id' => 345
        },
        {
          'name' => 'VideoFilmes',
          'id' => 346
        },
        {
          'name' => 'Globo filmes',
          'id' => 10954
        },
        {
          'name' => 'Lumiere',
          'id' => 11444
        },
        {
          'name' => 'Wild Bunch',
          'id' => 856
        },
        {
          'name' => 'Hank Levine Film',
          'id' => 11445
        },
        {
          'name' => 'Lereby Productions',
          'id' => 11446
        }
      ])
      expect(movie.production_countries).to eq([
        {
          'iso_3166_1' => 'BR',
          'name' => 'Brazil'
        },
        {
          'iso_3166_1' => 'FR',
          'name' => 'France'
        }
      ])
      expect(movie.release_date).to eq('2002-08-31')
      expect(movie.revenue).to eq(27387381)
      expect(movie.runtime).to eq(130)
      expect(movie.spoken_languages).to eq([
        {
          'iso_639_1' => 'pt',
          'name' => 'Português'
        }
      ])
      expect(movie.status).to eq('Released')
      expect(movie.tagline).to eq('If you run you\'re dead...if you stay, you\'re dead again. Period.')
      expect(movie.title).to eq('City of God')
      expect(movie.vote_average).to eq(8.2)
      expect(movie.vote_count).to eq(52)
    end

    it 'find a movie given your ID and language' do
      stub_get('/movie/550').with(query: { language: 'pt' })
        .to_return(json_response('find_movie_by_id_and_language.json'))

      movie = TMDb::Movie.find(550, language: 'pt')

      expect(movie.adult).to eq(false)
      expect(movie.backdrop_path).to eq('/kkS8PKa8c134vXsj2fQkNqOaCXU.jpg')
      expect(movie.belongs_to_collection).to eq({
        'id' => 2883,
        'name' => 'Kill Bill Collection',
        'poster_path' => '/tf1nUtw3LJGUGv1EFFi23iz6ngr.jpg',
        'backdrop_path' => '/oCLKNACMNrEf4T1EP6BpMXDl5m1.jpg'
      })
      expect(movie.budget).to eq(55000000)
      expect(movie.genres).to eq([
        {
          'id' => 28,
          'name' => 'Ação'
        },
        {
          'id' => 80,
          'name' => 'Crime'
        },
        {
          'id' => 53,
          'name' => 'Thriller'
        }
      ])
      expect(movie.homepage).to eq('')
      expect(movie.id).to eq(24)
      expect(movie.imdb_id).to eq('tt0266697')
      expect(movie.original_title).to eq('Kill Bill: Vol. 1')
      expect(movie.overview).to eq('Kill Bill presta uma grande homenagem aos filmes de Kung-fu das décadas de 60 e 70, seus atores e estilos. Dirigido com exímia presteza, a obra foi delicadamente produzida o que dá ao expectador um deleite frente às diversas mudanças de sensibilidade do filme, cenas em preto e branco, seqüências, sombras, ângulos de câmera e intertextualidade com outras mídias como o trecho do filme feito em anime e a sensacional trilha sonora que se tornou um dos deliciosos hábitos viciantes dos filmes de Tarantino. O primeiro volume do filme narra o início da vingança da ex-assassina Black Mamba (cujo nome real só nos é revelado ao final do segundo filme). Ao acordar do coma, Black Mamba percebe que foi a única sobrevivente do extermínio ocorrido no dia de seu casamento e que levara as vidas de todos a quem amava, inclusive do filho que levava no ventre. Ela começa então uma caçada impiedosa aos assassinos, seus ex-companheiros do esquadrão de assassinato Deadly Viper.')
      expect(movie.popularity).to eq(2.884757761614897)
      expect(movie.poster_path).to eq('/viscNSLi1rDyMuTytUojf0G2DIy.jpg')
      expect(movie.production_companies).to eq([
        {
          'name' => 'Miramax Films',
          'id' => 14
        },
        {
          'name' => 'A Band Apart',
          'id' => 59
        }
      ])
      expect(movie.production_countries).to eq([
        {
          'iso_3166_1' => 'JP',
          'name' => 'Japan'
        },
        {
          'iso_3166_1' => 'US',
          'name' => 'United States of America'
        }
      ])
      expect(movie.release_date).to eq('2003-10-09')
      expect(movie.revenue).to eq(180949000)
      expect(movie.runtime).to eq(111)
      expect(movie.spoken_languages).to eq([
        {
          'iso_639_1' => 'en',
          'name' => 'English'
        }
      ])
      expect(movie.status).to eq('Released')
      expect(movie.tagline).to eq('')
      expect(movie.title).to eq('Kill Bill - Volume 1')
      expect(movie.vote_average).to eq(7.6)
      expect(movie.vote_count).to eq(92)
    end

    it 'raises error with id not found' do
      stub_get('/movie/1234').to_return(json_response('invalid_id.json', 404))
      expect { TMDb::Movie.find(1234) }.to raise_error(ArgumentError)
    end
  end
end
