class CreateNotesPeople < ActiveRecord::Migration
  def change
    create_table :notes_people do |t|
      t.integer :note_id
      t.integer :person_id

      t.timestamps
    end
  end
end
