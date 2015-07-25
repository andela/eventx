class EventsController < ApplicationController
  before_action :redirect_to_user_sign_in, only: [:new]
  
  def new
  end

  def show

  end
end
