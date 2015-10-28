class AddColumnmanagerProfileIdtoevents < ActiveRecord::Migration
  def change
    add_column :events, :manager_profile_id, :integer
    add_index  :events, :manager_profile_id
    add_column :manager_profiles, :domain, :string
  end
end
