FactoryGirl.define do
  factory :person do
    firstname { Faker::Name.first_name }
    lastname  { Faker::Name.last_name }
    phone     { Faker::PhoneNumber.phone_number }
    household

    factory :person_without_household do
      household nil
    end
  end
end
