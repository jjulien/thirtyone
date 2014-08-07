# == Schema Information
#
# Table name: addresses
#
#  id         :integer          not null, primary key
#  line1      :string(255)
#  line2      :string(255)
#  city       :string(255)
#  zip        :string(255)
#  state_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

class Address < ActiveRecord::Base
  belongs_to :state
end
