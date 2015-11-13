class UsersController < ApplicationController
  before_action :authenticate_user, only: [:show]

  def show
    @user = current_user
    if params[:search]
      @events = @user.events.search_by_event_name(params[:search])
      respond_to do |format|
        format.html
        format.js { render 'show.js.erb'  }
      end
    else
      @events = @user.events
    end
  end


  # def user_params
  #   params.require(:user).permit(:provider, :uid, :first_name, :last_name,
  #   :email, :profile_url, :oauth_token, :oauth_token_expires_at)
  # end
end
