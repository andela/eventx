class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :user
      t.string :title
      t.text :body
      t.string :sender
      t.boolean :read, default: false, null: false

      t.timestamps null: false
    end
  end
end
