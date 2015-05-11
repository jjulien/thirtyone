class RolePolicy < ApplicationPolicy
  attr_reader :user

  def initialize(user, obj)
    @user = user
  end

  def index?
    @user.has_access?(PERM_RO_USER)
  end

  def show?
    @user.has_access?(PERM_RO_USER)
  end

  def new?
    @user.has_access?(PERM_ADMIN)
  end

  def edit?
    @user.has_access?(PERM_ADMIN)
  end

  def bulk_assign_create?
    @user.has_access?(PERM_ADMIN)
  end

  def bulk_assign_new?
    @user.has_access?(PERM_ADMIN)
  end

  def create?
    @user.has_access?(PERM_ADMIN)
  end

  def update?
    @user.has_access?(PERM_ADMIN)
  end

  def destroy?
    @user.has_access?(PERM_ADMIN)
  end
end