FactoryGirl.define do
  factory :booking do
    user_id 1
    event_id 1
    uniq_id "MyString"
    amount 1
    txn_id "MyString"
    payment_status 1
    user_tickets_count 1
  end
end