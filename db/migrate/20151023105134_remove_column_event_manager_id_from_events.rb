class RemoveColumnEventManagerIdFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :event_manager_id
  end
end
