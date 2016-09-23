FactoryGirl.define do
  factory :task do
    name { Faker::Lorem.sentence }
    event
    association :user, factory: :regular_user
    association :assigner, factory: :user
  end

  trait :completed do
    completed_status true
  end
end
