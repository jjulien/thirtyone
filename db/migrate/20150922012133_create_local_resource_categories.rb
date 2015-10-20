class CreateLocalResourceCategories < ActiveRecord::Migration
  def change
    create_table :local_resource_categories do |t|
      t.string :name

      t.timestamps null: false
    end

    create_table :local_resource_categories_resources do |t|
      t.integer :local_resource_category_id
      t.integer :local_resource_id
    end
  end
end
