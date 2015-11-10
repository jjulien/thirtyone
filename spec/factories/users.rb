FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }

    trait :with_admin_role do
      after(:create) do |user|
        user.roles << create(:admin_role)
      end
    end
  end
end
