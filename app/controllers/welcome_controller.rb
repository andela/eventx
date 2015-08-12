class WelcomeController < ApplicationController

  def index
    @events = Event.recent_events
  end


  def featured
    @events = Event.featured_events
  end

  def popular
    @events = Event.popular_events
  end


  def set
    session[:url] = events_new_path
  end
end
