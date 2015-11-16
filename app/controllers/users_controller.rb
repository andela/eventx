class UsersController < ApplicationController
  before_action :authenticate_user, only: [:show]

  def show
    @user = current_user
    if params[:search]
      @events = @user.events.search_by_event_name(params[:search])
      respond_to do |format|
        format.html
        format.js { render "show.js.erb"  }
      end
    else
      @events = @user.events
    end
  end
end
