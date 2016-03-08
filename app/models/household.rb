# == Schema Information
#
# Table name: households
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  person_id  :integer
#  created_at :datetime
#  updated_at :datetime
#  address_id :integer
#

class Household < ActiveRecord::Base
  belongs_to :person
  belongs_to :address
  has_and_belongs_to_many :notes, join_table: 'notes_households'
  alias_method :head, :person
  has_many :members, class_name: 'Person', foreign_key: 'household_id'
  accepts_nested_attributes_for :address
  validates_associated :address

  def summary
    s = "#{person.formal_name}"
    s << " - #{self.address.oneline_summary}" if self.address
  end

  def name
    person.lastname
  end

  #alias_method :people, :persons
  #alias_method :members, :persons

end
