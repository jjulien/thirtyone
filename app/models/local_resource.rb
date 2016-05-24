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

include ActionView::Helpers::NumberHelper

class LocalResource < ActiveRecord::Base
  has_and_belongs_to_many :local_resource_categories
  validates_presence_of :local_resource_categories
  validates_presence_of :business_name
  validates_associated :address
  number_to_phone(:phone, area_code: true, extension: :phone_ext) # => (123) 123-1234 x 555
  belongs_to :address
  before_save :strip_phone

  accepts_nested_attributes_for :address

  def strip_phone
    self.phone = self.phone.gsub(/\D/, '')
    self.phone_ext = self.phone_ext.gsub(/\D/, '')
  end
end
