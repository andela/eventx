class CreateNotificationSubscriptions < ActiveRecord::Migration
  def change
    create_table :notification_subscriptions do |t|
      t.references :user, null: false
      t.references :category, null: false
      t.boolean :inbox_notification, default: true
      t.boolean :email_notification, default: false
      t.timestamps null: false
    end
    add_index :notification_subscriptions, ["user_id", "category_id"]
  end
end
