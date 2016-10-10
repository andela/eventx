class RemoveColumnFromEvent < ActiveRecord::Migration
  def change
    remove_column :events, :recurring, :boolean
  end
end
