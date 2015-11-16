class WelcomeController < ApplicationController
  def index
    @events = Event.upcoming_events
  end

  def featured
    @events = Event.featured_events
  end

  def popular
    @events = Event.popular_events
  end
end
