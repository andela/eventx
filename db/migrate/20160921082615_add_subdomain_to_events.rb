class AddSubdomainToEvents < ActiveRecord::Migration
  def change
    add_column :events, :subdomain, :string
  end
end
