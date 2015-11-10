FactoryGirl.define do
  factory :ticket_type, :class => "TicketType" do
    quantity 1
    event_id 1
    price "9.99"
    name "MyString"
    factory :ticket_type2 do
      event_id 2
    end
  end
end
