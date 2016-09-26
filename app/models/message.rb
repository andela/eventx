class Message < ActiveRecord::Base
  belongs_to :user
  scope :unread, -> { where(read: false) }
  validates_presence_of :title, :body, :sender
end
