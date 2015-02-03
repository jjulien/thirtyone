class CreateWorkSchedules < ActiveRecord::Migration
  def change
    create_table :work_schedules do |t|
      t.integer :staff_id
      t.datetime :start_at
      t.datetime :end_at
      t.string :note

      t.timestamps
    end
  end
end
