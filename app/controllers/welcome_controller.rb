class WelcomeController < ApplicationController
  def index
    @events = Event.upcoming_events
  end

  def featured
    @events = Event.featured_events
    render "welcome/events_list", layout: false
  end

  def popular
    @events = Event.popular_events
    render "welcome/events_list", layout: false
  end
end
