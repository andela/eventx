class UserTicket < ActiveRecord::Base
  belongs_to :user
  belongs_to :ticket_type
end
