# == Schema Information
#
# Table name: people
#
#  id           :integer          not null, primary key
#  firstname    :string
#  lastname     :string
#  phone        :string
#  phone_ext    :string
#  created_at   :datetime
#  updated_at   :datetime
#  household_id :integer
#  email        :string
#

class Person < ActiveRecord::Base
  include PhoneMethod

  acts_as_paranoid
#  has_notes
  has_and_belongs_to_many :notes
  belongs_to :household, autosave: true
  has_one :user, autosave: true
  validates_presence_of :firstname, :lastname, :household
  validates_associated :household
  validate :custom_validate
  before_save :strip_phone_number

  def fullname
    if lastname
      "#{firstname} #{lastname}"
    else
      firstname
    end
  end

  def formal_name
    fn = lastname || ''
    fn += ', ' if fn and firstname and fn.length > 0 and firstname.length > 0
    fn += firstname if firstname and firstname.length > 0
    fn
  end

  def self.users
    Person.includes(:user).where.not(users: {id: nil})
  end

  def email=(new_email)
    #  Do not set email if user has a pending email change.  The
    #  confirm_email_change on the people controller will set the email
    #  after the change has been confirmed for the user
    unless user.nil? || user.has_pending_email_change?
      self[:email] = new_email
    end
  end

  def has_pending_email_change?
    user.nil? ? false : user.has_pending_email_change?
  end

  def add_custom_error(attribute, message)
    if @custom_errors.nil?
      @custom_errors = {}
    end
    @custom_errors[attribute] = message
  end

  def custom_validate
    unless @custom_errors.nil?
      @custom_errors.each do |k, v|
        errors.add(k.to_sym, v)
      end
    end
  end

  def strip_phone_number
    self.phone = self.strip_phone(self.phone)
    self.phone_ext = self.strip_phone_ext(self.phone_ext)
  end
end
