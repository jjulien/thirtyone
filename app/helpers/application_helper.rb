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

  # This is used to determine if the current user is the default admin and if they are trying to update
  # the account without knowning this, we would just put the user in an endless loop of redirecting to
  # a GET of the adminsetup page
  def requested_admin_setup_page?
    valid_actions = ['update', 'send_confirmation_email']
    return ( params[:controller] == 'users' and current_user.email == 'admin' and valid_actions.include?(params[:action])  )
  end

  private
  def is_duplicate?(person)
    Person.select { |p| p.id != person.id && p.fullname == person.fullname }.any?
  end
end
