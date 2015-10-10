FactoryGirl.define do
  factory :note_type do
    name { Faker::Lorem.word }
  end
end
