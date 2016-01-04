class Attendee < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  validates :user_id, presence: true
end
