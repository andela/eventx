class RemoveUserIdFromUserTickets < ActiveRecord::Migration
  def change
    remove_reference :user_tickets, :user, index: true
  end
end
