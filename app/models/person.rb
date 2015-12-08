# == Schema Information
#
# Table name: people
#
#  id           :integer          not null, primary key
#  firstname    :string(255)
#  lastname     :string(255)
#  phone        :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  household_id :integer
#  email        :string(255)
#

class Person < ActiveRecord::Base
#  has_notes
  has_and_belongs_to_many :notes
  belongs_to :household, autosave: true
  has_one :user, autosave: true
  validates_presence_of :firstname, :lastname, :household
  validates_associated :household
  validate :custom_validate

  def fullname
    if lastname
      "#{firstname} #{lastname}"
    else
      firstname
    end
  end

  def formal_name
    fn = lastname if lastname
    fn += ', ' if fn and firstname and fn.length > 0 and firstname.length > 0
    fn += firstname if firstname and firstname.length > 0
    fn
  end

  def self.users
    Person.includes(:user).where.not(users: {id: nil})
  end

  def email=(new_email)
    #  Do not set email if user has a pending email change.  The
    #  user model will set the email for us after it clears
    #  the pending change.
    if user.nil? or not user.has_pending_email_change?
        self[:email] = new_email
    end
  end

  def has_pending_email_change?
    if not user.nil?
      user.has_pending_email_change?
    else
      false
    end
  end

  def add_custom_error(attribute, message)
    if @custom_errors.nil?
      @custom_errors = {}
    end
    @custom_errors[attribute] = message
  end

  def custom_validate
    if not @custom_errors.nil?
      @custom_errors.each do |k, v|
        errors.add(k.to_sym, v)
      end
    end
  end
end
