FactoryGirl.define do
  factory :note do
    note { Faker::Lorem.paragraph(4) }
    note_type
  end
end
