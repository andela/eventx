class Attendee < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  validates_presence_of :user_id, :event_id
  validate :cannot_attend_one_event_twice

  # validation
  def cannot_attend_one_event_twice
    if event.attendees.include? user
      errors.add(:user_id, "You have already chosen to attend this event!")
    end
  end
end
