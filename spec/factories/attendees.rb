FactoryGirl.define do
  factory :attendee do
    user
    association :event, factory: :regular_event
  end
end
