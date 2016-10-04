class RemoveParentIdFromReviews < ActiveRecord::Migration
  def change
    remove_column :reviews, :parent_id
  end
end
