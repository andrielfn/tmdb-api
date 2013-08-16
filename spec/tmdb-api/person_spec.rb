require "spec_helper"

describe TMDb::Person do
  describe '.find' do
    before do
      stub_get('/person/1327').to_return(json_response('person/find.json'))
    end

    let!(:person) { TMDb::Person.find(1327) }

    it 'returns "adult" attribute' do
      expect(person.adult).to eq(false)
    end

    it 'returns "also_known_as" as array of strings' do
      expect(person.also_known_as).to match_array([
    		'Sir Ian McKellan',
    		'Sir Ian McKellen',
    		'Ian Murray McKellen'
      ])
    end

    it 'return "biography" attribute' do
      expect(person.biography).to start_with("Sir Ian Murray McKellen is an English actor.")
    end

    it 'returns "birthday" attribute' do
      expect(person.birthday).to eq('1939-05-25')
    end

    it 'returns "deathday" attribute' do
      expect(person.deathday).to eq('')
    end

    it 'returns "homepage" attribute' do
      expect(person.homepage).to eq('http://www.mckellen.com/')
    end

    it 'returns "id" attribute' do
      expect(person.id).to eq(1327)
    end

    it 'returns "imdb_id" attribute' do
      expect(person.imdb_id).to eq('nm0005212')
    end

    it 'returns "name" attribute' do
      expect(person.name).to eq('Ian McKellen')
    end

    it 'returns "place_of_birth" attribute' do
      expect(person.place_of_birth).to eq('Burnley, England')
    end

    it 'returns "popularity" attribute' do
      expect(person.popularity).to eq(16.0104684226102)
    end

    it 'returns "profile_path" attribute' do
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

      expect(popular.first.adult).to eq(false)
      expect(popular.first.name).to eq('Daniel Craig')
      expect(popular.first.profile_path).to eq('/wWMdqiqW6unT6TnXydQbOtYffeO.jpg')
    end

    it 'raises with a bad request' do
      stub_get('/person/popular').with(query: { page: 200 }).to_return(status: 404)
      expect{ TMDb::Person.popular(page: 200) }.to raise_error ArgumentError
    end
  end
end
