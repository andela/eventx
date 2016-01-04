class RemoveUniqIdAndPaymentStatusFromUserTickets < ActiveRecord::Migration
  def change
    remove_column :user_tickets, :uniq_id, :string
    remove_column :user_tickets, :payment_status, :boolean
  end
end
