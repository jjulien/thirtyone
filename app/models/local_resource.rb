# == Schema Information
#
# Table name: local_resources
#
#  id            :integer          not null, primary key
#  business_name :string
#  phone         :string
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
  validates_format_of :phone, :allow_nil => true, :allow_blank => true, :with => /[0-9]{3}-[0-9]{3}-[0-9]{4}/
  belongs_to :address

  accepts_nested_attributes_for :address
end
