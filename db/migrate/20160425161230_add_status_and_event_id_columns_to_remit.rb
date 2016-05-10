class AddStatusAndEventIdColumnsToRemit < ActiveRecord::Migration
  def change
    add_column :remits, :status, :string, default: "requested"
    add_column :remits, :event_id, :integer
  end
end
