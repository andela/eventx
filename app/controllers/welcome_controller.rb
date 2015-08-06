class WelcomeController < ApplicationController


  def index
    @events = Event.recent_events
  end

  def set
    session[:url] = events_new_path
  end
end
