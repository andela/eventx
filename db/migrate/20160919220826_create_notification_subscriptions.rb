class CreateNotificationSubscriptions < ActiveRecord::Migration
  def change
    create_table :notification_subscriptions do |t|
      t.references :user
      t.references :category
      t.boolean :inbox_notification
      t.boolean :email_notification
      t.timestamps null: false
    end
    add_index :notification_subscriptions, ["user_id", "category_id"]
  end
end