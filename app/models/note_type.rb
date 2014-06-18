# == Schema Information
#
# Table name: note_types
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class NoteType < ActiveRecord::Base
end
