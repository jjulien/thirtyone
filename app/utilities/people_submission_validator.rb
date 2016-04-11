class PeopleSubmissionValidator
  attr_reader :params, :errors, :is_new_user
  def initialize(params)
    @params = params
    @errors = {}
  end

  def process(person)
    household = check_for_household
    household ||= create_new_household
    check_create_new_user(person)
    add_person_attributes(person, household)
    is_invalid?(person)
    if errors.empty?
      persist_entry(household, person)
    else
      compute_errors(person)
    end
  end

  def persist_entry(household, person)
    begin
      Person.transaction do
        save(household)
        person.household = household
        save(person)
        household.update!(person: person) unless household.person
        return true
      end
      true
    rescue ActiveRecord::RecordInvalid => exception
        @errors['validation'] = exception.message
        false
    end
  end

  def save(obj)
    obj.save!
  end

  def is_invalid?(obj)
    obj.valid? ? nil : @errors[obj.class.to_s] = obj.errors.full_messages.join(", ")
  end

  def add_person_attributes(person, household)
    person_params.each{ |key, val| person[key] = val }
    person.household = household
  end

  def check_for_household
    household_id = person_params[:household_id]
    Household.find_by(id: household_id)
  end

  def create_new_household
    state = State.find_by(id: address_params[:state_id])
    address = Address.new(address_params)
    return if (is_invalid?(address) || state.nil?)

    household = Household.new
    household.address = address
    household
  end

  def check_create_new_user(person)
    unless params[:create_user] == "yes"
      person.user.destroy if person.user
      return
    end

    user_email = person_params[:email]
    if user_email.blank?
      @errors[:email] = "is required when the person is also allowed to login"
    elsif user_email !~ Devise.email_regexp
      @errors[:email] = "is not valid"
    else
      user = person.user || User.new
      person.user = setup_user(user, user_email)
    end
  end

  def setup_user(user, user_email)
    user.email = user_email
    user.password = Devise.friendly_token.first(8)
    user.confirm_email_change
    user.roles = check_for_and_add_roles
    is_invalid?(user) ? nil : user
  end

  def check_for_and_add_roles
    roles = params[:roles].map { |role| Role.find_by(id: role)  }
    roles.reject(&:nil?)
  end

  def compute_errors(person)
    errors.each{ |key, val| person.errors.add(key.downcase, val) }
    false
  end

  def address_params
    return Hash.new unless params[:address]
    params.require(:address).permit(:line1, :line2, :city, :state, :zip, :state_id)
  end

  def person_params
    params.require(:person).permit(:firstname, :lastname, :phone, :household_id, :email)
  end

end
