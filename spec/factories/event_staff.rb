FactoryGirl.define do
  factory :event_staff do
    user
    event
    role EventStaff.roles.values.sample

    trait :event_staff do
      role 0
    end

    trait :gate_keeper do
      role 1
    end

    trait :collaborator do
      role 2
    end

    trait :logistics do
      role 3
    end

    trait :sponsor do
      role 4
    end

    trait :volunteer do
      role 5
    end
  end
end
