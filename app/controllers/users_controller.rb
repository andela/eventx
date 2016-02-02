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
    render json: User.lookup_email(params[:term])
  end

  def fetch_user_info
    @user = User.find_by(id: params[:user_id])
    render layout: false, partial: "fetch_user_info",
           locals: { user: @user, role: nil }
  end

  private

  def search_params
    params.permit(:event_name).symbolize_keys
  end
end
