class CreateNotificationSubscriptions < ActiveRecord::Migration
  def change
    create_table :notification_subscriptions do |t|
      t.references :user
      t.references :category
      t.boolean :status
      t.timestamps null: false
    end
    add_index :notification_subscriptions, ["user_id", "category_id"]
  end
end
