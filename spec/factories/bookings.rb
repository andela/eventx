FactoryGirl.define do
  factory :booking do
    uniq_id "MyString"
    amount 1
    txn_id "MyString"
    payment_status 1
    user_tickets_count 1
  end
end
