require 'spec_helper'

describe TMDb::Searchable do
  subject { TMDb::Movie }

  it 'returns the right resource' do
    expect(subject.resource).to eql 'movie'
  end
end
