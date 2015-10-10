require 'rails_helper'

describe Note do

  it 'has a valid factory' do
    expect(build(:note)).to be_valid
  end

end
