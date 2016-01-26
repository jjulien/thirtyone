# == Schema Information
#
# Table name: households
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  person_id  :integer
#  created_at :datetime
#  updated_at :datetime
#  address_id :integer
#

require 'test_helper'

class HouseholdTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
