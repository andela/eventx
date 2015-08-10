class AddBannerToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :banner, :string
  end
end
