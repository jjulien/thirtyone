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

include ActionView::Helpers::NumberHelper

class Person < ActiveRecord::Base
  acts_as_paranoid
#  has_notes
  has_and_belongs_to_many :notes
  belongs_to :household, autosave: true
  has_one :user, autosave: true
  validates_presence_of :firstname, :lastname, :household
  validates_associated :household
  number_to_phone(:phone, area_code: true, extension: :phone_ext) # => (123) 123-1234 x 555
  #validates_format_of :phone, :allow_nil => true, :allow_blank => true, :with => /[0-9]{3}-[0-9]{3}-[0-9]{4}/
  validate :custom_validate

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

end
