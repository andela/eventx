class EventStaff < ActiveRecord::Base
  enum role: [:event_staff, :event_manager, :super_admin]
  validates :role, presence: true
  validates :user, presence: true

  belongs_to :user
  belongs_to :event
end
