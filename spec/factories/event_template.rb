FactoryGirl.define do
  factory :event_template do
    name { Faker::Lorem.word }
    image { Faker::Avatar.image }
  end
end
