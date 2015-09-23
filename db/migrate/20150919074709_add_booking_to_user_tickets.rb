class AddBookingToUserTickets < ActiveRecord::Migration
  def change
    add_reference :user_tickets, :booking, index: true
  end
end
