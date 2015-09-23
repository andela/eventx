class AddAmountToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :amount, :integer
  end
end
