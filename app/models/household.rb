class Household < ActiveRecord::Base
  has_many :persons
  alias_method :people, :persons
  alias_method :members, :persons

end
