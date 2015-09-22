# == Schema Information
#
# Table name: work_schedules
#
#  id         :integer          not null, primary key
#  staff_id   :integer
#  start_at   :datetime
#  end_at     :datetime
#  note       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class WorkSchedule < ActiveRecord::Base
  belongs_to :user, foreign_key: 'user_id', class_name: 'User'
end
