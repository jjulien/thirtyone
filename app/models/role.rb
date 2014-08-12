# == Schema Information
#
# Table name: roles
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#

class Role < ActiveRecord::Base

  has_many :user_roles
  has_many :users, :through => :user_roles

end
