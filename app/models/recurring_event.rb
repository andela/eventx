class RecurringEvent < ActiveRecord::Base
  belongs_to :event

  FREQUENCY = %w(Daily Weekly Monthly).freeze
  WEEK = %w(First Second Third Fourth).freeze
  DAY = %w(Sunday Monday Tuesday Wednesday Thursday Friday Saturday).freeze

  validates :day, presence: true, if: "frequency == 'Weekly'"
  validates :week, presence: true, if: "frequency == 'Monthly'"
end
