FactoryGirl.define do
  factory :event do
    title "Blessings wedding"
    description "Happy day of joy celebration happinness smiles."
    location "Beach side"
    start_date Time.zone.now + 3600
    end_date Time.zone.now + 86_400 * 7
    image "http://graph.facebook.com/1065771400114300/picture"
    theme_id 1
    category_id 1
    venue "Beside the waters"
    event_template_id 1
    map_url "http://www.example.com/gothere"
    ticket_types { build_list(:ticket_type_free, 1) }
    manager_profile

    factory :paid_event do
      ticket_types { build_list(:ticket_type_paid, 1) }
    end

    factory :next_week_event do
      title "Next week Event"
      start_date Time.zone.now.end_of_week + 86_400 * 3
      end_date Time.zone.now.end_of_week + 86_400 * 4
    end

    factory :tomorrow_event do
      title "Tomorrow Event"
      start_date Time.zone.tomorrow
      end_date Time.zone.tomorrow
    end

    factory :next_weekend_event do
      title "Next weekend Event"
      start_date Time.zone.now.end_of_week + 86_400 * 5
      end_date Time.zone.now.end_of_week + 86_400 * 5
    end

    factory :this_weekend_event do
      title "This weekend Event"
      start_date Time.zone.now.end_of_week
      end_date Time.zone.now.end_of_week
    end

    factory :sport_event do
      category_id 6
      title "Sports is cool"
    end

    factory :old_event do
      title "Old Event"
      start_date Time.zone.now - 86_400 * 7
      end_date Time.zone.now
      category
      event_template
    end

    trait :cancelled do
      enabled false
    end

    factory :regular_event, parent: :event do
      category
      event_template
      association :manager_profile, factory: :regular_manager_profile
    end
  end
end
