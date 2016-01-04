class CreateEventStaffs < ActiveRecord::Migration
  def change
    create_table :event_staffs do |t|
      t.integer :role
      t.references :user, index: true
      t.references :event, index: true

      t.timestamps null: false
    end
  end
end
