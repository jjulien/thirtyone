class PersonPolicy < ApplicationPolicy
  attr_reader :user, :person

  def initialize(user, person)
    @user = user
    @person = person
  end

  def index?
    false
  end

  def show?
    true
  end

  def create?
    true
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  # def scope
  #   Pundit.policy_scope!(user, Person)
  # end
end

