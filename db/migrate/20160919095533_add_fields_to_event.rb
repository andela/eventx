class AddFieldsToEvent < ActiveRecord::Migration
  def change
    add_column :events, :start_time, :time
    add_column :events, :end_time, :time
    add_column :events, :recurring, :boolean
  end
end
