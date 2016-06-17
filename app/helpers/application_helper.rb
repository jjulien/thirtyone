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

  private
  def is_duplicate?(person)
    Person.select { |p| p.id != person.id && p.fullname == person.fullname }.any?
  end

  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to(name, "javascript:;", :onclick => "remove_fields(this)")
  end

  def link_to_add_fields(name, f, association, parent_selector=nil)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    onclick = "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\""
    if parent_selector
      onclick += ", \"#{parent_selector}\""
    end
    onclick += ")"

    link_to name,
            "javascript:;",
            :class => 'button medium',
            :onclick => onclick
  end

end