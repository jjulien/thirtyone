class AddEmailChangeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :reset_email_token, :string
    add_column :users, :reset_email_token_sent_at, :datetime
    add_column :users, :pending_email, :string
  end
end
