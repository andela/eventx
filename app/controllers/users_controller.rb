class UsersController < ApplicationController
  before_action :authenticate_user, only: [:show]
  respond_to :html, :json, :js

  def show
    @user = current_user
    @events = @user.events
    if params[:search]
      @events = @events.search_by_event_name(params[:search])
    end
    respond_with @events
  end
end
