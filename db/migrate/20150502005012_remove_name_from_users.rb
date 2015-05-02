class RemoveNameFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :field_name, :name
  end
end
