module ApplicationHelper
  def deduplicate_user(user)
    # Find users with duplicate fullnames.
    # If there is a duplicate, then the label should have <name> (<email>)
    # to help differentiate the users.
    is_duplicate?(user.person) ? "#{user.person.fullname} (#{user.email})" : user.person.fullname
  end

  def deduplicate_person(person)
    # Find people with duplicate fullnames.
    # If there is a duplicate, then the label should have <name> (<address line 1>)
    # to help differentiate the people.
    is_duplicate?(person) ? "#{person.fullname} (#{person.household.address.line1})" : person.fullname
  end

  def admin_setup_complete?
    if user_signed_in? and current_user.email == 'admin'
      return false
    end
    return true
  end

  private
  def is_duplicate?(person)
    Person.select { |p| p.id != person.id && p.fullname == person.fullname }.any?
  end
end
