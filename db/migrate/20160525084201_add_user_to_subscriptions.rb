class AddUserToSubscriptions < ActiveRecord::Migration
  def change
    add_reference :subscriptions, :user, index: true, foreign_key: true
  end
end
