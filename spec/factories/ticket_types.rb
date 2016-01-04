FactoryGirl.define do
  factory :ticket_type do
    quantity 1
    event_id 1
    price "9.99"
    name "MyString"
    factory :ticket_type2 do
      event_id 2
    factory :ticket_type4 do
      quantity 1
      event_id 1
      price "0.00"
      name "Ticket"
    end
    end
  end

  factory :ticket_type3 do
    quantity 1
    event_id 2
    price "9.99"
    name "MyString"
  end
end
