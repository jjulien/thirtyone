class CreateNotesVisits < ActiveRecord::Migration
  def change
    create_table :notes_visits do |t|
      t.integer :note_id
      t.integer :visit_id

      t.timestamps
    end
  end
end
