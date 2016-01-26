# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
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
#  person_id              :integer
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable
  validate :validate_pending_email

  has_many :user_roles
  has_many :roles, :through => :user_roles
  belongs_to :person, autosave: true

  @send_confirmation = false

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

  def has_access?(permission)
    permissions & PERM_ADMIN > 0 || permissions & permission > 0
  end

  def email=(new_email)
    if email != new_email
      self[:reset_email_token] = Devise.friendly_token
      self[:reset_email_token_sent_at] = DateTime.now
      self[:pending_email] = new_email
      @send_confirmation = true
    else
      self[:email] = new_email
    end
  end

  def confirm_email_change
    if has_pending_email_change?
      self[:email] = self[:pending_email]
      cancel_pending_email_change
    end
  end

  def cancel_pending_email_change
    self[:reset_email_token]         = nil
    self[:reset_email_token_sent_at] = nil
    self[:pending_email]             = nil
  end

  def should_send_confirmation_email?
    @send_confirmation
  end

  def send_confirmation_email
    send_devise_notification(:confirmation_instructions, reset_email_token, {})
  end

  def has_pending_email_change?
    return ( not pending_email.nil? and not reset_email_token_sent_at.nil? and ( reset_email_token_sent_at > ( DateTime.now - Devise.confirm_within ) ) )
  end

  def pending_email_valid?
    if has_pending_email_change? and User.find_by_email(pending_email) != nil
      return false
    end
    return true
  end

  def validate_pending_email
      if not pending_email_valid?
        errors.add(:email, "already exists")
    end
  end
end
