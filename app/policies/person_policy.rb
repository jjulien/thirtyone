class PersonPolicy < ApplicationPolicy
  attr_reader :user, :person

  def initialize(user, person)
    @user = user
    @person = person
  end

  def index?
    @user.has_access?(PERM_RO_PERSON)
  end

  def show?
    @user.has_access?(PERM_RO_PERSON)
  end

  def create?
    @user.has_access?(PERM_RW_PERSON)
  end

  def new?
    create?
  end

  def update?
    @user.has_access?(PERM_RW_PERSON)
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end

  def search?
    index?
  end

  def cancel_pending_email_change?
    @user.has_access?(PERM_RW_PERSON)
  end

  def send_confirmation_email?
    @user.has_access?(PERM_RW_PERSON)
  end

  # Email confirmations should not require a login, so we will always authorize.
  # The token in the URL is the real authorization mechanism.
  def confirm_email_change?
    true
  end
  # def scope
  #   Pundit.policy_scope!(user, Person)
  # end
end

