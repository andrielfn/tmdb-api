require 'spec_helper'

describe TMDb::Movie do
  describe '#images' do
    it 'returns the images (posters and backdrops) for a specific movie ID' do
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

    it 'raises with a bad request' do
      stub_get('/movie/598/images').to_return(status: 404)

      expect { TMDb::Movie.images(598) }.to raise_error ArgumentError
    end
  end
end
