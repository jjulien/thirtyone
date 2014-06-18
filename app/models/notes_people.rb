# == Schema Information
#
# Table name: notes_people
#
#  id         :integer          not null, primary key
#  note_id    :integer
#  person_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class NotesPeople < ActiveRecord::Base
end
