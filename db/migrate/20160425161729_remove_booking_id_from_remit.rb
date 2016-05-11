class RemoveBookingIdFromRemit < ActiveRecord::Migration
  def change
    remove_column :remits, :booking_id, :integer
  end
end
