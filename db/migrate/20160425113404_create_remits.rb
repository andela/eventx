class CreateRemits < ActiveRecord::Migration
  def change
    create_table :remits do |t|
      t.integer :booking_id

      t.timestamps null: false
    end
  end
end
