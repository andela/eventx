class ChangePaymentStatusOnBooking < ActiveRecord::Migration
  def change
    remove_column :bookings, :payment_status, :integer
    add_column :bookings, :payment_status, :integer, default: 0, null: false
  end
end
