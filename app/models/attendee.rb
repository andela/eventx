class Attendee < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  validates :user_id,
            :presence => true,
            :uniqueness => {:message => "You are already attending this event"}
end
