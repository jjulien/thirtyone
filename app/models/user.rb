# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable

  has_many :user_roles
  has_many :roles, :through => :user_roles
  belongs_to :person

  def send_new_account_instructions
     token = set_reset_password_token
     send_new_account_instructions_notification(token)
     token
  end
  def send_new_account_instructions_notification(token)
     send_devise_notification(:new_account_instructions, token, {})
  end

  def permissions
    permissions = 0
    roles.each do |r|
      permissions |= r.permissions
    end
    return permissions
  end

  def has_access(permission)
    permissions & PERM_ADMIN > 0 || permissions & permission > 0
  end
end
