class CreateRecurringEvents < ActiveRecord::Migration
  def change
    create_table :recurring_events do |t|
      t.string :frequency
      t.string :days
      t.references :event, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
