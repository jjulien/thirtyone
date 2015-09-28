require 'rails_helper'

describe Role do

  it 'should have a valid factory' do
    expect(build(:role)).to be_valid
  end
end
