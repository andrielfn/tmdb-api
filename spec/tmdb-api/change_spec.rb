require 'spec_helper'

describe TMDb::Changes do
  describe '.movies' do
    it 'returns the changed movies' do
      stub_get('/movie/changes').to_return(json_response('changes/movies.json'))

      changes = TMDb::Changes.movies

      expect(changes['results']).to have(100).items
      expect(changes['total_results']).to eql(4645)
      expect(changes['total_pages']).to eql(47)
      expect(changes['page']).to eql(1)
      expect(changes['results'].first).to eql({
        'id' => 128149,
        'adult' => false
      })
    end

    it 'raises with a bad request' do
      stub_get('/movie/changes').to_return(status: 404)

      expect { TMDb::Changes.movies }.to raise_error ArgumentError
    end
  end
end
