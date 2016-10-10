class EventStaff < ActiveRecord::Base
  enum role: [
    :event_staff,
    :gate_keeper,
    :collaborator,
    :logistics,
    :sponsor,
    :volunteer
  ]
  validates :role, presence: true
  validates :user, presence: true

  belongs_to :user
  belongs_to :event
end
