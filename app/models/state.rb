class State < ActiveRecord::Base
  alias_attribute :abbv, :abbreviation
end
