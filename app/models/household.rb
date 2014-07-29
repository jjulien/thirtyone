# == Schema Information
#
# Table name: households
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  person_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class Household < ActiveRecord::Base
  has_one :person
  alias_method :head, :person

  def summary
    person.formal_name
  end

  #alias_method :people, :persons
  #alias_method :members, :persons

end
