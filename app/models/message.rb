class Message < ActiveRecord::Base
  belongs_to :user
  scope :unread, -> { where(read: false) }
end
