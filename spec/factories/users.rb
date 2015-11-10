FactoryGirl.define do
  factory :user do
    id 1
    status 0
    first_name "Blessing"
    last_name "Ebowe"
    email "eb@gmaill.com"
    profile_url "http://graph.facebook.com/1065771400114300/picture"
    provider "facebook"
    uid "1065771400114300"
  end
end
