FactoryGirl.define do
  factory :recurring_event do
    frequency "Monthly"
    day "Thursday"
    week "First"
    event
  end
end
