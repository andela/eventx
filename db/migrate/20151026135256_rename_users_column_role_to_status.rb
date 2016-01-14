class RenameUsersColumnRoleToStatus < ActiveRecord::Migration
  def change
    rename_column :users, :role, :status
  end
end
