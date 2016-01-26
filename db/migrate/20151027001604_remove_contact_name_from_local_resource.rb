class RemoveContactNameFromLocalResource < ActiveRecord::Migration
  def change
    remove_column :local_resources, :contact_name, :string
  end
end
