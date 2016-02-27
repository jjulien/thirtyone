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

  validates_presence_of :line1, :city, :zip
  validates_format_of :zip, :with => /\d{5}/

  def city_state_zip
    "#{self.city}, #{self.state.abbv} #{self.zip}"
  end

  def oneline_summary
    summary = ""
    summary << "#{self.line1}" if self.line1
    unless self.line2.blank?
      if summary
       summary << ', '
      else
         summary << ' '
      end
      summary << self.line2
    end
    summary << ", #{self.city_state_zip}"
  end

  def self.most_used_state
    State.find(Address.group(:state_id).order('count_state_id DESC').limit(1).count(:state_id).keys.first || 1)
  end
end
