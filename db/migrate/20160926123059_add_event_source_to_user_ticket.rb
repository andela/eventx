class AddEventSourceToUserTicket < ActiveRecord::Migration
  def change
    add_column :user_tickets, :event_source, :string
  end
end
