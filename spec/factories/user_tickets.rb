FactoryGirl.define do
  factory :user_ticket do
    ticket_number "MyString"
    event_source "Facebook"
    booking_id 1
    ticket_type_id 1
  end
end
