class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.string :email
      t.integer :role
      t.string :token
      t.boolean :accepted
      t.references :event, index: true
      t.references :sender, index: true

      t.timestamps null: false
    end
  end
end
