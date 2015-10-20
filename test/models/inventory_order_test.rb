# == Schema Information
#
# Table name: inventory_orders
#
#  id         :integer          not null, primary key
#  peopleid   :integer
#  enteredby  :integer
#  date       :date
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class InventoryOrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
