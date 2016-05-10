FactoryGirl.define do
  factory :event_staff do
    user
    event
    role 0

    trait :gate_keeper do
      role 1
    end
  end
end
