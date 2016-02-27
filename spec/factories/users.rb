FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }

    trait :with_person_ro_role do
      after(:create) do |user|
        user.roles << create(:person_ro_role)
      end
    end

    trait :with_person_rw_role do
      after(:create) do |user|
        user.roles << create(:person_ro_role)
        user.roles << create(:person_rw_role)
      end
    end

    trait :with_admin_role do
      after(:create) do |user|
        user.roles << create(:admin_role)
      end
    end
  end
end
