# == Schema Information
#
# Table name: work_schedules
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  start_at   :datetime
#  end_at     :datetime
#  note       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class WorkScheduleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
