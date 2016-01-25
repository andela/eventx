class UsersController < ApplicationController
  before_action :authenticate_user, only: [:show]
  respond_to :json, :html, :js

  def show
    # query = search_params.merge(user_id: current_user.id)
    @events = Event.search(search_params)
    respond_with @events
  end

  def users_with_likely_emails(email)
    User.with_alike_email(email).to_json
  end

  def search_params
    params.permit(:event_name).symbolize_keys
  end
end
