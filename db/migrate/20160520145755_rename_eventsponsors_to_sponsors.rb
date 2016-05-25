class RenameEventsponsorsToSponsors < ActiveRecord::Migration
  def change
    rename_table :eventsponsors, :sponsors
  end
end
