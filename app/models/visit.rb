class Visit < ActiveRecord::Base
  has_and_belongs_to_many :notes
  belongs_to :person

end
