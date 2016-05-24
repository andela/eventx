class CreateEventsponsors < ActiveRecord::Migration
  def change
    create_table :eventsponsors do |t|
      t.string :name
      t.string :logo
      t.string :url
      t.text :summary
      t.references :event, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
