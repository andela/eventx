class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :role, default: 0
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :profile_url
      t.string :provider
      t.string :uid

      t.timestamps null: false
    end
  end
end
