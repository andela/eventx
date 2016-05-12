class AddRefundToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :refund_requested, :boolean, default: false
    add_column :bookings, :time_requested, :datetime
    add_column :bookings, :granted, :boolean, default: false
    add_column :bookings, :granted_by, :integer
    add_column :bookings, :time_granted, :datetime
  end
end
