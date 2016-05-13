class AddLevelToEventsponsors < ActiveRecord::Migration
  def change
    add_column :eventsponsors, :level, :integer
  end
end
