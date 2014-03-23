require "spec_helper"

describe TMDb::Person do
  describe '.find' do
    before do
      stub_get('/person/1327').to_return(json_response('person/find.json'))
    end

    let!(:person) { TMDb::Person.find(1327) }

    it 'returns a TMDb::Person object with the filled attributes' do
      expect(person.adult).to eq(false)
      expect(person.also_known_as).to match_array([
        'Sir Ian McKellan',
        'Sir Ian McKellen',
        'Ian Murray McKellen'
      ])
      expect(person.biography).to start_with("Sir Ian Murray McKellen is an English actor.")
      expect(person.birthday).to eq(Date.parse('1939-05-25'))
      expect(person.deathday).to eq(nil)
      expect(person.homepage).to eq('http://www.mckellen.com/')
      expect(person.id).to eq(1327)
      expect(person.imdb_id).to eq('nm0005212')
      expect(person.name).to eq('Ian McKellen')
      expect(person.place_of_birth).to eq('Burnley, England')
      expect(person.popularity).to eq(16.0104684226102)
      expect(person.profile_path).to eq('/c51mP46oPgAgFf7bFWVHlScZynM.jpg')
    end

    it 'raises with a bad request' do
      stub_get('/person/666').to_return(status: 404)
      expect { TMDb::Person.find(666) }.to raise_error(ArgumentError)
    end
  end

  describe '.images' do
    it 'gets the images given an person ID' do
      stub_get('/person/8557/images').to_return(json_response('person/images.json'))

      images = TMDb::Person.images(8557)

      expect(images['profiles'].first).to eq({
  			"file_path" => '/j77Z3f2m0e211ocFhPJu5ZiO12R.jpg',
  			"width" => 290,
  			"height" => 290,
  			"iso_639_1" => nil,
  			"aspect_ratio" => 1.0
      })
    end

    it 'raises with a bad request' do
      stub_get('/person/666/images').to_return(status: 404)
      expect { TMDb::Person.images(666) }.to raise_error ArgumentError
    end
  end

  describe '.popular' do
    it 'gets a list of popular people' do
      stub_get('/person/popular').to_return(json_response('person/popular.json'))

      popular = TMDb::Person.popular

      expect(popular.first.id).to eq(63)
      expect(popular.first.adult).to eq(false)
      expect(popular.first.name).to eq('Milla Jovovich')
      expect(popular.first.popularity).to eq(24.8431766091385)
      expect(popular.first.profile_path).to eq('/mcNgLarIVho7LheWcvd1oQ2tBOg.jpg')

      known_for = popular.first.known_for.first
      expect(known_for). to be_an_instance_of(TMDb::KnownFor)
      expect(known_for.id).to eq(18)
      expect(known_for.title).to eq('The Fifth Element')
      expect(known_for.media_type).to eq('movie')
    end

    it 'raises with a bad request' do
      stub_get('/person/popular').with(query: { page: 200 }).to_return(status: 404)
      expect{ TMDb::Person.popular(page: 200) }.to raise_error ArgumentError
    end
  end
end
