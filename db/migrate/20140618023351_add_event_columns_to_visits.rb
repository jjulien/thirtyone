class AddEventColumnsToVisits < ActiveRecord::Migration
  def change
    add_column :visits, :start_at, :datetime
    add_column :visits, :end_at, :datetime
  end
end
