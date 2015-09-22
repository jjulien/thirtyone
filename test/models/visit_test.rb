# == Schema Information
#
# Table name: visits
#
#  id         :integer          not null, primary key
#  person_id  :integer
#  visit_date :date
#  host_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  start_at   :datetime
#  end_at     :datetime
#

require 'test_helper'

class VisitTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
