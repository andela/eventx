class Event < ActiveRecord::Base
  belongs_to :category
  belongs_to :event_template
  has_many :tickets, dependent: :destroy

  accepts_nested_attributes_for :tickets
end
