require "spec_helper"

describe TMDb::Person do
  describe '.find' do
    it "find a person given an ID" do
      stub_get('/person/1327').to_return(json_response('person/find.json'))

      person = TMDb::Person.find(1327)

      expect(person.adult).to eq(false)
      expect(person.also_known_as).to match_array([
    		'Sir Ian McKellan',
    		'Sir Ian McKellen',
    		'Ian Murray McKellen'
      ])
      expect(person.biography).to eq("Sir Ian Murray McKellen is an English actor. He has received a Tony Award and two Academy Award nominations. His work has spanned genres from Shakespearean and modern theatre to popular fantasy and science fiction. He is known to many for roles such as Gandalf in the Lord of the Rings film trilogy and as Magneto in the X-Men films.  In 1988, McKellen came out and announced he was gay. He became a founding member of Stonewall, one of the United Kingdom's most influential LGBT rights groups, of which he remains a prominent spokesman.  He was made a Commander of the Order of the British Empire (CBE) in 1979, and knighted in the 1991 New Year Honours for his outstanding work and contributions to theatre. In the 2008 New Year Honours he was made a Companion of Honour (CH) for services to drama and to equality.")
      expect(person.birthday).to eq('1939-05-25')
      expect(person.deathday).to eq('')
      expect(person.homepage).to eq('http://www.mckellen.com/')
      expect(person.id).to eq(1327)
      expect(person.imdb_id).to eq('nm0005212')
      expect(person.name).to eq('Ian McKellen')
      expect(person.place_of_birth).to eq('Burnley, England')
      expect(person.popularity).to eq(16.0104684226102)
      expect(person.profile_path).to eq('/c51mP46oPgAgFf7bFWVHlScZynM.jpg')
    end

    it "raises with a bad request" do
      stub_get('/person/666').to_return(status: 404)
      expect { TMDb::Person.find(666) }.to raise_error(ArgumentError)
    end
  end

  describe '.images' do
    it "gets the images given an person ID" do
      stub_get('/person/8557/images').to_return(json_response('person/images.json'))

      images = TMDb::Person.images(8557)

      expect(images['profiles'].first).to eq({
  			"file_path" => "/j77Z3f2m0e211ocFhPJu5ZiO12R.jpg",
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
    it "gets a list of popular people" do
      stub_get('/person/popular').to_return(json_response('person/popular.json'))

      popular = TMDb::Person.popular

      expect(popular.first.adult).to eq(false)
      expect(popular.first.name).to eq('Daniel Craig')
      expect(popular.first.profile_path).to eq("/wWMdqiqW6unT6TnXydQbOtYffeO.jpg")
    end

    it "raises with a bad request" do
      stub_get('/person/popular').with(query: { page: 200 }).to_return(status: 404)
      expect{ TMDb::Person.popular(page: 200).to raise_error ArgumentError }
    end
  end
end
