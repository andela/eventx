class UsersController < ApplicationController

  def show
    
  end


  def user_params
    params.require(:user).permit(:provider, :uid, :first_name, :last_name, :email, :profile_url, :oauth_token, :oauth_token_expires_at)
  end
end
