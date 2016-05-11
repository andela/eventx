class AddUsedAndTimeUsedToUserTicket < ActiveRecord::Migration
  def change
    add_column :user_tickets, :is_used, :boolean, default: false
    add_column :user_tickets, :time_used, :datetime
  end
end
