require "spec_helper"

describe TMDb do
  it "sets a API Key" do
    TMDb.api_key = '131asdasd'
    expect(TMDb.api_key).to eql('131asdasd')
  end
end
