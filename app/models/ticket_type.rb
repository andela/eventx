class TicketType < ActiveRecord::Base
  belongs_to :event
  has_many :user_tickets
end
