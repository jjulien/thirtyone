class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.integer :person_id
      t.date :visit_date
      t.integer :host_id

      t.timestamps
    end
  end
end
