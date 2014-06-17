class Note < ActiveRecord::Base
  belongs_to :note_type
#  has_and_belongs_to_many :person
#  has_and_belongs_to_many :visit
end
