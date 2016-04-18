class AddDayToHighlight < ActiveRecord::Migration
  def change
    add_column :highlights, :day, :date
  end
end
