class NotificationSubscription < ActiveRecord::Base
  belongs_to :subscriber, class_name: "User", foreign_key: "user_id"
  belongs_to :category
end
