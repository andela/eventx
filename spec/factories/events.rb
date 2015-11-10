FactoryGirl.define do
  factory :event do
    title "Blessings wedding"
    description "Happy day of joy celebration happinness smiles."
    location "Beach side"
    start_date Time.now
    end_date Time.now + 86400 * 7
    image "http://graph.facebook.com/1065771400114300/picture"
    theme_id 1
    category_id 1
    venue "Beside the waters"
    event_template_id 1
    map_url "gothere"
    manager_profile_id 1
    factory :event_with_ticket do
      id 1
      transient do
        tickets_count 1
      end
      after(:create) do |event, evaluator|
        create_list(:ticket_type, evaluator.tickets_count, event: event)
      end
      factory :event_with_ticket1 do
        id 2
      end
      factory :sport_event do
        id 3
        category_id 2
        title "Sports is cool"
      end
    end
  end
end
