class AddUniqIdToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :uniq_id, :string
  end
end
