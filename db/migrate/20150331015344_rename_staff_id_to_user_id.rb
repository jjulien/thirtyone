class RenameStaffIdToUserId < ActiveRecord::Migration
  def change
    rename_column :work_schedules, :staff_id, :user_id
  end
end
