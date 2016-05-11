class AddColumnsToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :remit_id, :integer
  end
end
