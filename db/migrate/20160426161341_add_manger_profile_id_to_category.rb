class AddMangerProfileIdToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :manager_profile_id, :integer, default: 0
  end
end
