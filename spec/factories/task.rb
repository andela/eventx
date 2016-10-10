FactoryGirl.define do
  factory :task do
    name { Faker::Lorem.sentence }
    association :event, factory: :regular_event
    association :user, factory: :regular_user
    association :assigner, factory: :regular_user
  end

  trait :completed do
    completed_status true
  end
end
