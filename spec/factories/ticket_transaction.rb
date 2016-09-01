FactoryGirl.define do
  factory :ticket_transaction do
    tickets ["1"]
    accepted false
    booking
  end
end
