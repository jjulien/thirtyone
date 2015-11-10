require 'rails_helper'

describe Role do

  it 'should have a valid factory' do
    expect(build(:admin_role)).to be_valid
  end

  context 'admin role' do
    before do
      @admin_role = build(:admin_role)
    end

    it 'has a valid factory' do
      expect(@admin_role).to be_valid
    end

    it 'has the correct permissions' do
      expect(@admin_role.permissions).to eq(PERM_ADMIN)
    end
  end
end
