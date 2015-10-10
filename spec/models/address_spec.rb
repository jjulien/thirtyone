require 'rails_helper'

describe Address do

  before(:each) { @address = build(:address) }

  it 'has a valid factory' do
    expect(FactoryGirl.build(:address)).to be_valid
  end

  it 'returns city, state, zip as a single string' do
    expect(@address.city_state_zip).to eq @address.city + ', ' + @address.state.abbreviation + ' ' + @address.zip
  end

  it 'returns a one line summary as a single string' do
    expect(@address.oneline_summary).to eq @address.line1 + ', ' + @address.city + ', ' + @address.state.abbreviation + ' ' + @address.zip
  end
end
