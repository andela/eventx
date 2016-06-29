class UsersController < ApplicationController
  before_action :authenticate_user
  respond_to :json, :html, :js

  def test
  end

  def show
    manager_profile = current_user.manager_profile
    manager_profile_id = manager_profile ? manager_profile.id : nil
    fetch_user_events(manager_profile_id)
  end

  def lookup_staff_emails
    user = User.lookup_email(params[:term])
    if user
      render json: user
    else
      render json: { error: "error" }
    end
  end

  def fetch_user_events(manager_profile_id)
    events = if current_user.event_manager?
               Event.my_event_search(search_params, manager_profile_id)
             else
               current_user.bookings.includes(:event)
             end
    @resources = WillPaginate::Collection.create(paginate_params, 5,
                                                 events.length) do |pager|
      pager.replace events[pager.offset, pager.per_page]
    end
    respond_with @resources
  end

  def fetch_user_info
    user_info = User.user_info(user_info_params)
    render json: user_info
  end

  private

  def paginate_params
    if params[:page].nil?
      1
    else
      params[:page]
    end
  end

  def search_params
    params.permit(:event_name, :enabled).symbolize_keys
  end

  def user_info_params
    params.permit(:user_id, :role)
  end
end
