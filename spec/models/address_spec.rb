require 'rails_helper'

describe Address do

  it 'has a valid factory' do
    expect(FactoryGirl.build(:address)).to be_valid
  end

  it 'returns city, state, zip as a single string' do
    expect(build(:address).city_state_zip).to eq 'Normal, IL 61761'
  end

  it 'returns a one line summary as a single string' do
    expect(build(:address).oneline_summary).to eq '1500 N. Airport Rd., Normal, IL 61761'
  end
end
