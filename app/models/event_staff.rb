class EventStaff < ActiveRecord::Base
  # enum role: [:event_staff, :gate_keeper, :event_manager, :super_admin]
  # remove event_role table
  enum role: [
    :volunteer, 
    :ticket_seller,
    :logistics,
    :manager,
    :collaborator 
  ]
  validates :role, presence: true
  validates :user, presence: true

  belongs_to :user
  belongs_to :event
end
