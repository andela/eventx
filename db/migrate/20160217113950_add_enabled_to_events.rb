class AddEnabledToEvents < ActiveRecord::Migration
  def change
    add_column :events, :enabled, :boolean, default: true
  end
end
