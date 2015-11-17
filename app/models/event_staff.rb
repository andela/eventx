class EventStaff < ActiveRecord::Base
  enum role: [:attendee, :event_staff, :event_manager, :super_admin ]
  
  belongs_to :user
  belongs_to :event
end
