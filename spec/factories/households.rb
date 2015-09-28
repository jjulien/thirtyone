FactoryGirl.define do
  factory :household do
    address

    factory :household_with_people do
      transient do
        people_count 5
      end

      after(:build) do |household, evaluator|
        create_list(:person, evaluator.people_count, household: household)
      end
    end
  end
end
