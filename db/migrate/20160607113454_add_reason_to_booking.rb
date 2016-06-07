class AddReasonToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :reason, :string
  end
end
