class AddOauthTokenAndOauthTokenExpiresAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :oauth_token, :string
    add_column :users, :oauth_token_expires_at, :datetime
  end
end
