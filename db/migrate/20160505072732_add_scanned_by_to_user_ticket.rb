class AddScannedByToUserTicket < ActiveRecord::Migration
  def change
    add_column :user_tickets, :scanned_by, :integer
  end
end
