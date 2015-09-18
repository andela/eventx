class CreateUserTickets < ActiveRecord::Migration
  def change
    create_table :user_tickets do |t|
      t.references :user, index: true
      t.references :ticket_type, index: true
      t.string :ticket_number

      t.timestamps null: false
    end
  end
end
