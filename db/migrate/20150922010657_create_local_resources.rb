class CreateLocalResources < ActiveRecord::Migration
  def change
    create_table :local_resources do |t|
      t.string :contact_name
      t.string :business_name
      t.string :phone
      t.string :email
      t.string :url
      t.integer :address_id

      t.timestamps null: false
    end
  end
end
