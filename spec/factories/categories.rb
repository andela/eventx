FactoryGirl.define do
  factory :category do
    id 1
    name "Music"
    description "Its a party."
    banner "MyString"
    factory :category2 do
      name "Sports"
      id 2
    end
    factory :category3 do
      name "Parties"
      id 3
    end
    factory :invalid_category do
      name nil
      id 2
    end
  end
end
