class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :note
      t.integer :note_type_id

      t.timestamps
    end
  end
end
