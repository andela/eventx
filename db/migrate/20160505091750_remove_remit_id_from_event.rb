class RemoveRemitIdFromEvent < ActiveRecord::Migration
  def change
    remove_column :events, :remit_id, :integer
  end
end
