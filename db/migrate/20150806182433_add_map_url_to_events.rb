class AddMapUrlToEvents < ActiveRecord::Migration
  def change
    add_column :events, :map_url, :string
  end
end
