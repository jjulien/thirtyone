require 'rails_helper'

describe State do

  it 'has a valid factory' do
    expect(build(:state)).to be_valid
  end

  it 'aliases the abbreviation attribute to abbv' do
    state = build(:state)
    expect(state.abbv).to eq state.abbreviation
  end

end
