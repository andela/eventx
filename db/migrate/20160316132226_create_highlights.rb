class CreateHighlights < ActiveRecord::Migration
  def change
    create_table :highlights do |t|
      t.references :event, index: true, foreign_key: true
      t.string :title
      t.text :description
      t.datetime :start_time
      t.datetime :end_time
      t.string :image
      t.string :image_title

      t.timestamps null: false
    end
  end
end
