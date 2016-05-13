class Eventsponsor < ActiveRecord::Base
  belongs_to :event

  validates :name, presence: true
  validates :logo, presence: true
end
