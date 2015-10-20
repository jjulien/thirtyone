# == Schema Information
#
# Table name: local_resource_categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :local_resource_category do
    name "MyString"
  end

end
