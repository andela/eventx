class EventStaff < ActiveRecord::Base
  include StaffRole

  validates :role, presence: true
  validates :user, presence: true

  belongs_to :user
  belongs_to :event
end
