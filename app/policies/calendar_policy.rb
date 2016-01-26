class CalendarPolicy < ApplicationPolicy
  attr_reader :user

  def initialize(user, calendar)
    @user = user
  end

  def index?
    ro?
  end

  def show?
    ro?
  end

  def create?
    rw?
  end

  def new?
    rw?
  end

  def update?
    rw?
  end

  def edit?
    rw?
  end

  def destroy?
    rw?
  end

  def person?
    ro?
  end

  def day?
    ro?
  end

  private
  def ro?
    @user && @user.has_access?(PERM_RO_SCHEDULE)
  end

  def rw?
    @user && @user.has_access?(PERM_RW_SCHEDULE)
  end
end
