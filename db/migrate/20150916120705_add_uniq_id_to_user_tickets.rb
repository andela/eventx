class AddUniqIdToUserTickets < ActiveRecord::Migration
  def change
    add_column :user_tickets, :uniq_id, :string
    add_column :user_tickets, :payment_status, :boolean, default: false
  end
end
