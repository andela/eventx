class AddRemitIdToEventColumn < ActiveRecord::Migration
  def change
    add_column :events, :remit_id, :integer
  end
end
