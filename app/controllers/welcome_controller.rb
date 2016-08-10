class WelcomeController < ApplicationController
  respond_to :html, :json
  def index
    @events = Event.upcoming_events
    respond_with @events
  end

  def about
  end

  def faq
  end

  def featured
    @events = Event.featured_events
    renders(@events)
  end

  def popular
    @events = Event.popular_events
    renders(@events)
  end

<<<<<<< HEAD
=======
  def about
  end

>>>>>>> 9116d09... [#126584711] change variable name to reflect count
  def renders(events)
    respond_with(events) do |format|
      format.html { render "welcome/events_list", layout: false }
      format.json { render json: events }
    end
  end
end
