class CreateEventTemplates < ActiveRecord::Migration
  def change
    create_table :event_templates do |t|
      t.string :name
      t.string :image

      t.timestamps null: false
    end
  end
end
