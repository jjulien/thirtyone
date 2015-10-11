class WorkSchedulePolicy < ApplicationPolicy
  attr_reader :user, :work_schedule

  def initialize(user, work_schedule)
    @user = user
    @work_schedule = work_schedule
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

  private
  def ro?
    @user && @user.has_access?(PERM_RO_SCHEDULE)
  end

  def rw?
    @user && @user.has_access?(PERM_RW_SCHEDULE)
  end
end

