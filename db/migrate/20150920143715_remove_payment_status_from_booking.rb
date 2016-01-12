class RemovePaymentStatusFromBooking < ActiveRecord::Migration
  def change
    remove_column :bookings, :payment_status, :boolean
    add_column :bookings, :payment_status, :integer
  end
end
