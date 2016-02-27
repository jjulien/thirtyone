require 'rails_helper'

describe User do

  it 'should have a valid factory' do
    expect(build(:user)).to be_valid
  end

  context 'admin user' do
    it 'should have admin permissions' do
      expect(create(:user, :with_admin_role).has_access?(PERM_ADMIN)).to be_truthy
    end
  end
end

