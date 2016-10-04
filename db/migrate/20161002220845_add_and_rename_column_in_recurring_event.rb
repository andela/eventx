class AddAndRenameColumnInRecurringEvent < ActiveRecord::Migration
  def change
    rename_column :recurring_events, :days, :day
    add_column :recurring_events, :week, :string
  end
end
