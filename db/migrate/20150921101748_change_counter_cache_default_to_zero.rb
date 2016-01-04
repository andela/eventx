class ChangeCounterCacheDefaultToZero < ActiveRecord::Migration
  def change
    remove_column :bookings, :user_tickets_count
    add_column :bookings, :user_tickets_count, :integer, default: 0
  end
end
