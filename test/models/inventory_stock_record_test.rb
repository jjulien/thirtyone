# == Schema Information
#
# Table name: inventory_stock_records
#
#  id         :integer          not null, primary key
#  itemid     :integer
#  quantity   :integer
#  received   :date
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class InventoryStockRecordTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
