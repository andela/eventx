class AddUserTicketsCountToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :user_tickets_count, :integer
  end
end
