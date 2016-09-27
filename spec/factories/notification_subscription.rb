FactoryGirl.define do
  factory :notification_subscription do
    user_id 1
    category_id 3
    inbox_notification true
    email_notification true
  end
end