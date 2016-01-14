class CreateManagerProfiles < ActiveRecord::Migration
  def change
    create_table :manager_profiles do |t|
      t.string :user_id
      t.string :subdomain
      t.string :company_name
      t.string :company_mail
      t.string :company_phone

      t.timestamps null: false
    end
  end
end
