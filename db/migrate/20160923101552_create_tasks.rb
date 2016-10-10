class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.boolean :completed_status, default: false
      t.references :event, index: true, foreign_key: true
      t.integer :user
      t.integer :assigner

      t.timestamps null: false
    end
  end
end
