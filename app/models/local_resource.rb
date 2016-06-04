# == Schema Information
#
# Table name: local_resources
#
#  id            :integer          not null, primary key
#  business_name :string
#  phone         :string
#  phone_ext     :string
#  email         :string
#  url           :string
#  address_id    :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class LocalResource < ActiveRecord::Base
  has_and_belongs_to_many :local_resource_categories
  validates_presence_of :local_resource_categories
  validates_presence_of :business_name
  validates_associated :address
  belongs_to :address
  before_save :strip_phone

  accepts_nested_attributes_for :address

  def strip_phone
    unless self.phone.nil?
      self.phone = self.phone.gsub(/\D/, '')
    end
    unless self.phone_ext.nil?
      self.phone_ext = self.phone_ext.gsub(/\D/, '')
    end
  end
end
