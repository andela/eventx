class UsersController < ApplicationController
  before_action :authenticate_user, only: [:show]

  def show
    @user = current_user
    @events = @user.events
    if params[:search]
      @events = @events.search_by_event_name(params[:search])
      respond_to do |format|
        format.html
        format.js { render "show.js.erb"  }
      end
    end
  end
end
