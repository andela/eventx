class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.integer :quantity
      t.integer :event_id
      t.decimal :price

      t.timestamps null: false
    end
  end
end
