class UsersController < ApplicationController
  before_action :authenticate_user
  respond_to :json, :html, :js

  def show
    manager_profile = current_user.manager_profile
    manager_profile_id = manager_profile ? manager_profile.id : nil
    @events = Event.my_event_search(search_params, manager_profile_id)
    respond_with @events
  end

  def lookup_staff_emails
    user = User.lookup_email(params[:term])
    if user
      render json: user
    else
      render json: { error: "error" }
    end
  end

  def fetch_user_info
    user_info = User.user_info(user_info_params)
    render json: user_info
  end

  private

  def search_params
    params.permit(:event_name, :enabled).symbolize_keys
  end

  def user_info_params
    params.permit(:user_id, :role)
  end
end
