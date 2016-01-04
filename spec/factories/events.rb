FactoryGirl.define do
  factory :event do
    title "Blessings wedding"
    description "Happy day of joy celebration happinness smiles."
    location "Beach side"
    start_date Time.zone.now + 86_400
    end_date Time.zone.now + 86_400 * 7
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
      factory :next_week_event do
        id 5
        title "Next week Event"
        start_date Time.zone.now.end_of_week + 86_400 * 3
        end_date Time.zone.now.end_of_week + 86_400 * 4
      end
      factory :tomorrow_event do
        id 8
        title "Tomorrow Event"
        start_date Time.zone.tomorrow
        end_date Time.zone.tomorrow
      end
      factory :next_weekend_event do
        id 6
        title "Next weekend Event"
        start_date Time.zone.now.end_of_week + 86_400 * 5
        end_date Time.zone.now.end_of_week  + 86_400 * 5
      end
      factory :this_weekend_event do
        id 7
        title "This weekend Event"
        start_date Time.zone.now.end_of_week - 86_400 * 2
        end_date Time.zone.now.end_of_week - 86_400 * 2
      end
      factory :sport_event do
        id 3
        category_id 2
        title "Sports is cool"
      end
      factory :old_event do
        id 4
        category_id 1
        title "Old Event"
        start_date Time.zone.now - 86_400 * 7
        end_date Time.zone.now
      end
    end
  end
end
