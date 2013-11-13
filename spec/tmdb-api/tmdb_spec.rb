require "spec_helper"

describe TMDb do
  it "sets an API Key" do
    TMDb.api_key = '74e5e63643c787867565659583634766'
    expect(TMDb.api_key).to eql('74e5e63643c787867565659583634766')
  end

  it 'raises when no API Key is set' do
    TMDb.api_key = ''
    expect { TMDb::Movie.find(550) }.to raise_error
  end

  it 'accepts the API Key from the environment variable' do
    TMDb.api_key = nil
    ENV['TMDB_API_KEY'] = '0beec7b5ea3f0fdbc95d0dd47f3c5bc275da8a33'
    expect(TMDb.api_key).to eql('0beec7b5ea3f0fdbc95d0dd47f3c5bc275da8a33')
  end
end
