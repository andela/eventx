class ChangeColumnDefault < ActiveRecord::Migration
  def change
    change_column_default :reviews, :rating, 3
  end
end
