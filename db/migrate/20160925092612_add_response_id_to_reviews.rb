class AddResponseIdToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :response_id, :integer
    add_column :reviews, :response_type, :string
  end
end
