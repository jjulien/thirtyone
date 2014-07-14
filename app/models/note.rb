# == Schema Information
#
# Table name: notes
#
#  id           :integer          not null, primary key
#  note         :string(255)
#  note_type_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Note < ActiveRecord::Base
  belongs_to :note_type
#  has_and_belongs_to_many :person
#  has_and_belongs_to_many :visit
end
