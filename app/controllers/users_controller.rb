class UsersController < ApplicationController
  before_action :authenticate_user, only: [:show]
  respond_to :json, :html, :js

  def show
    @events = current_user.events
    if params[:search]
      @events = @events.search(params[:search])
    end
    respond_with @events
  end
end
