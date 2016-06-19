FactoryGirl.define do
  factory :review do
    body { Faker::Lorem.sentence }
    rating 3
    user
    association :event, factory: :regular_event
  end
end
