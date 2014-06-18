# == Schema Information
#
# Table name: notes_visits
#
#  id         :integer          not null, primary key
#  note_id    :integer
#  visit_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

class NotesVisit < ActiveRecord::Base
end
