class AddColumnsToRemit < ActiveRecord::Migration
  def change
    add_column :remits, :total_amount, :integer
  end
end
