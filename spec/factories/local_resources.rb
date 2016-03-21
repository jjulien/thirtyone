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

FactoryGirl.define do
  factory :local_resource do
    contact_name "MyString"
business_name "MyString"
phone "123-456-7890"
#phone "MyString"
email "MyString"
url "MyString"
address ""
  end

end
