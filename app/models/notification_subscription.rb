class NotificationSubscription < ActiveRecord::Base
  belongs_to :subscriber, class_name: "User", foreign_key: "user_id"
  belongs_to :category
  validates_presence_of :user_id, :category_id
end
