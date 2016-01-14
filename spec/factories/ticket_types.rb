FactoryGirl.define do
  factory :ticket_type do
    name "MyTicket"
    quantity 1
    factory :ticket_type_free do
      price "0.00"
    end
    factory :ticket_type_paid do
      price "9.99"
    end
  end
end
