class AddEventSourceToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :event_source, :string
  end
end
