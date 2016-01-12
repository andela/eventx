class WelcomeController < ApplicationController
  def index
    @events = Event.upcoming_events
    respond_with @events
  end

  def featured
    @events = Event.featured_events
    renders(@events)
  end

  def popular
    @events = Event.popular_events
    renders(@events)
  end

  def renders(events)
    respond_with(events) do |format|
      format.html { render "welcome/events_list", layout: false }
      format.json { render json: events }
    end
  end
end
