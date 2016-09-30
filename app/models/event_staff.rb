class EventStaff < ActiveRecord::Base
  include StaffRole

  validates :role, presence: true
  validates :user,
            presence: true,
            uniqueness: {
              scope: :event, message: " has already been added to this event"
            }

  belongs_to :user
  belongs_to :event
end
