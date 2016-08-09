class WelcomeController < ApplicationController
  respond_to :html, :json
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

  def about
    @attendee_count = Attendee.count
    @ticket_count = UserTicket.count
    @event_count = Event.count
    @sponsor_count = Sponsor.count
  end

  def renders(events)
    respond_with(events) do |format|
      format.html { render "welcome/events_list", layout: false }
      format.json { render json: events }
    end
  end
end
