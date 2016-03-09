class AddIndexToEventStaff < ActiveRecord::Migration
  def change
    add_index :event_staffs, [:user_id, :event_id], unique: true
  end
end
