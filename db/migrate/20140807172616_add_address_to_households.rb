class AddAddressToHouseholds < ActiveRecord::Migration
  def change
    add_column :households, :address_id, :integer
  end
end
