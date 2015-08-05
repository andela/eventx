class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.string :location
      t.datetime :start_date
      t.datetime :end_date
      t.string :image
      t.integer :theme_id
      t.integer :category_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
