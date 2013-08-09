require "spec_helper"

describe TMDb::Person do
  describe '.find' do
    it "find a person given an ID" do
      stub_get('/person/8557').to_return(json_response('person/find.json'))

      person = TMDb::Person.find(8557)

      expect(person.adult).to eq(false)
      expect(person.also_known_as).to eq([])
      expect(person.biography).to eq("From Wikipedia, the free encyclopedia.\n\nFernando Meirelles (born November 9, 1955 in São Paulo, Brazil) is a Brazilian film director.\n\nHe was nominated for an Academy Award for Best Director in 2004 for his work in the Brazilian film City of God, released in 2002 in Brazil and in 2003 in the U.S. by Miramax Films. He was also nominated for the Golden Globe Best Director award in 2005 for The Constant Gardener.\n\nDescription above from the Wikipedia article Fernando Meirelles, licensed under CC-BY-SA, full list of contributors on Wikipedia.")
      expect(person.birthday).to eq("1955-11-09")
      expect(person.deathday).to eq("")
      expect(person.homepage).to eq("")
      expect(person.id).to eq(8557)
      expect(person.name).to eq("Fernando Meirelles")
      expect(person.place_of_birth).to eq("São Paulo, Brazil")
      expect(person.popularity).to eq(1.4749)
      expect(person.profile_path).to eq("/j77Z3f2m0e211ocFhPJu5ZiO12R.jpg")
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
