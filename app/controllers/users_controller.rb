class UsersController < ApplicationController
  before_action :authenticate_user, only: [:show]
  respond_to :json, :html, :js

  def show
    @events = current_user.events
    if search_params[:event_name]
      @events = @events.search(search_params.symbolize_keys)
    end
    respond_with @events
  end

  def search_params
    params.permit(:event_name)
  end
end
