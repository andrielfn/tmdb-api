require "spec_helper"

describe TMDb do
  it "sets a API Key" do
    TMDb.api_key = '74e5e63643c787867565659583634766'
    expect(TMDb.api_key).to eql('74e5e63643c787867565659583634766')
  end

  it 'raises when use no API' do
    TMDb.api_key = ''
    expect { TMDb::Movie.find(550) }.to raise_error
  end
end
