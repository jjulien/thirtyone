class AddHouseholdToPeople < ActiveRecord::Migration
  def change
    add_column :people, :household_id, :integer
  end
end
