require 'spec_helper'

describe TMDb::Movie do
  describe '.upcoming' do
    it 'returns the upcoming movies' do
      stub_get('/movie/upcoming').to_return(json_response('movie/upcoming.json'))

      upcoming = TMDb::Movie.upcoming

      expect(upcoming).to have(20).movies
      expect(upcoming.first.id).to eql(68726)
      expect(upcoming.first.title).to eql('Pacific Rim')
    end

    it 'returns the upcoming movies of page 2' do
      stub_get('/movie/upcoming').with(query: { page: 2 }).
        to_return(json_response('movie/upcoming_page_2.json'))

      upcoming = TMDb::Movie.upcoming(page: 2)

      # TODO: find a way to return the page number, total_pages and total_results
      # expect(page).to eql(2)
      expect(upcoming).to have(20).movies
      expect(upcoming.first.id).to eql(185407)
      expect(upcoming.first.title).to eql('Israel: A Home Movie / Kach Ra’inu')
    end
  end
end
