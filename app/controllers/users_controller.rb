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
    @user = User.find_by(id: params[:user_id])
    render layout: false, partial: "fetch_user_info", locals: { user: @user }
  end

  def search_params
    params.permit(:event_name).symbolize_keys
  end
end
