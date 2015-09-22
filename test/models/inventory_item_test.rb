# == Schema Information
#
# Table name: inventory_items
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  quantity   :integer
#  barcode    :string(255)
#  unit       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class InventoryItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
