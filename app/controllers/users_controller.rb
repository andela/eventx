class UsersController < ApplicationController
  before_action :authenticate_user, only: [:show]
  respond_to :json, :html, :js

  def show
    # query = search_params.merge(user_id: current_user.id)
    @events = Event.search(search_params)
    respond_with @events
  end

  def lookup_staff_emails
    render json: User.lookup_email(params[:entry])
  end

  def fetch_user_info
    @user = User.first
    render layout: false
  end

  def search_params
    params.permit(:event_name).symbolize_keys
  end
end
