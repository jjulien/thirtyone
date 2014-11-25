class AddPermissionToRole < ActiveRecord::Migration
  def change
    add_column :roles, :permissions, :integer, :default => 0
  end
end
