class CreateTicketTransactions < ActiveRecord::Migration
  def change
    create_table :ticket_transactions do |t|
      t.integer :booking_id
      t.integer :recipient_id
      t.text :tickets
      t.boolean :accepted, default: false 

      t.timestamps null: false
    end
  end
end
