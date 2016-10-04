class RecurringEvent < ActiveRecord::Base
  belongs_to :event

  FREQUENCY = ["Daily", "Weekly", "Monthly"]
  WEEK = ["First", "Second", "Third", "Fourth"]
  DAY = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]

  validates :day, presence: true, if: "frequency == 'Weekly'"
  validates :week, presence: true, if: "frequency == 'Monthly'"
end