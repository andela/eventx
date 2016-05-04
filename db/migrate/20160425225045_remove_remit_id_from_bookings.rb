class RemoveRemitIdFromBookings < ActiveRecord::Migration
  def change
    remove_column :bookings, :remit_id, :integer
  end
end
