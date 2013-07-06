require 'spec_helper'

describe TMDb::Changes do
  describe '.movies' do
    it 'returns the changed movies' do
      stub_get('/movie/changes').to_return(json_response('changes/movie_changes.json'))

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

    it 'returns the changed movies of page 2' do
      stub_get('/movie/changes').with(query: { page: 2 }).
        to_return(json_response('changes/movie_changes_page_2.json'))

      changes = TMDb::Changes.movies(page: 2)

      expect(changes['results']).to have(100).items
      expect(changes['total_results']).to eql(4648)
      expect(changes['total_pages']).to eql(47)
      expect(changes['page']).to eql(2)
      expect(changes['results'].first).to eql({
        'id' => 163536,
        'adult' => false
      })
    end

    it 'returns the changed movies filtered by start_date' do
      stub_get('/movie/changes').with(query: { start_date: '2013-07-05' }).
        to_return(json_response('changes/movie_changes_start_date.json'))

      changes = TMDb::Changes.movies(start_date: '2013-07-05')

      expect(changes['results']).to have(100).items
      expect(changes['total_results']).to eql(773)
      expect(changes['total_pages']).to eql(8)
      expect(changes['page']).to eql(1)
      expect(changes['results'].first).to eql({
        'id' => 205372,
        'adult' => false
      })
    end
  end
end
