class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.references :user, index: true
      t.references :event, index: true

      t.timestamps null: false
    end
  end
end
