FactoryGirl.define do
  factory :event_staff do
    role 1
    user_id 1
    event_id 1
    factory :invalid_staff1 do
      user_id nil
    end
    factory :invalid_staff2 do
      event_id nil
    end
  end
end
