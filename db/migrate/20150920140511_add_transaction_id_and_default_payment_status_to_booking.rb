class AddTransactionIdAndDefaultPaymentStatusToBooking < ActiveRecord::Migration
  def change
    remove_column :bookings, :payment_status, :boolean
    add_column :bookings, :payment_status, :boolean, default: false
    add_column :bookings, :txn_id, :string
  end
end
