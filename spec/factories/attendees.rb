FactoryGirl.define do
  factory :attendee do
    id 1
    user_id 1
    event_id 1
    factory :invalid_attendee do
      id 2
      user_id nil
    end
    factory :invalid_attendee2 do
      id 3
      event_id nil
    end
  end
end
