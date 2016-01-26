# == Schema Information
#
# Table name: local_resource_categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class LocalResourceCategory < ActiveRecord::Base
  has_and_belongs_to_many :local_resources
end
