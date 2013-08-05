require 'spec_helper'

describe TMDb::Movie do
  describe '#alternative_titles' do
    it 'returns the alternative titles for a specific movie' do
      stub_get('/movie/598/alternative_titles')
        .to_return(json_response('alternative_titles.json'))

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

    it 'returns the alternative titles for a specific movie and a specific country' do
      stub_get('/movie/598/alternative_titles').with(query: { country: 'br' })
        .to_return(json_response('alternative_titles_by_country.json'))

      alternative_titles = TMDb::Movie.alternative_titles(598, country: 'br')

      expect(alternative_titles).to match_array([
        {
          'iso_3166_1' => 'BR',
          'title' => 'Cidade de Deus'
        }
      ])
    end

    it 'raises with a bad request' do
      stub_get('/movie/invalid-id/alternative_titles').to_return(status: 404)

      expect { TMDb::Movie.alternative_titles('invalid-id') }
        .to raise_error ArgumentError
    end
  end
end
