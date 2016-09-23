FactoryGirl.define do
  factory :event_staff do
    user
    event
    role 0

    trait :ticket_seller do
      role 5
    end

    trait :collaborator do
      role 4
    end

    trait :manager do
      role 3
    end

    trait :logistics do
      role 2
    end

    trait :gate_keeper do
      role 1
    end

    trait :volunteer do
      role 0
    end
  end
end
