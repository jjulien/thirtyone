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

class Visit < ActiveRecord::Base
  has_event_calendar
  has_and_belongs_to_many :notes
  belongs_to :person
end
