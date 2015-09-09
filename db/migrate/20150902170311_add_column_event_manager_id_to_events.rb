class AddColumnEventManagerIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :event_manager_id, :integer
  end
end
