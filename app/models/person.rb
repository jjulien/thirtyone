# == Schema Information
#
# Table name: people
#
#  id         :integer          not null, primary key
#  firstname  :string(255)
#  lastname   :string(255)
#  phone      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Person < ActiveRecord::Base
#  has_notes
  has_and_belongs_to_many :notes
  def fullname
    firstname if not lastname else "#{firstname} #{lastname}"
  end

end
