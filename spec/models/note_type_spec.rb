require 'rails_helper'

describe NoteType do

  it 'has a valid factory' do
    expect(build(:note_type)).to be_valid
  end
end
