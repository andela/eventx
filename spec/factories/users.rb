FactoryGirl.define do
  factory :user do
    status 2
    first_name "Blessing"
    last_name "Ebowe"
    email "eb@gmaill.com"
    profile_url "http://graph.facebook.com/1065771400114300/picture"
    provider "facebook"
    uid "1065771400114300"

    trait :manager do
      manager_profile
    end

    factory :regular_user, parent: :user do
      status 0
      first_name  { Faker::Name.first_name }
      last_name  { Faker::Name.last_name }
      email { Faker::Internet.email }
      profile_url { Faker::Internet.url('graph.facebook.com') }
      provider "facebook"
      uid { Faker::Lorem.characters(16) }
    end
  end
end
