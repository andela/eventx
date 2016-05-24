class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references :event, index: true, foreign_key: true
      t.references :manager_profile, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
