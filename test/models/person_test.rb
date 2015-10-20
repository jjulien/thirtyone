# == Schema Information
#
# Table name: people
#
#  id           :integer          not null, primary key
#  firstname    :string(255)
#  lastname     :string(255)
#  phone        :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  household_id :integer
#  email        :string(255)
#

require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
