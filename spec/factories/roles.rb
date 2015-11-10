FactoryGirl.define do
  factory :role do
    name { Faker::Lorem.word }

    factory :admin_role do
      name 'Admin'
      permissions PERM_ADMIN
    end
  end
end
