class AddTransferedToUserTickets < ActiveRecord::Migration
  def change
    add_column :user_tickets, :transfered, :boolean, default: false 
  end
end
