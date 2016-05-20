class EventsponsorsController < ApplicationController
  before_action :find_event
  before_action :all_sponsors
  respond_to :html, :js

  def index
    @event_sponsors = @event.eventsponsors.group_by(&:level)
  end

  def new
    @event_sponsor = @event.eventsponsors.new
  end

  def create
    @event_sponsor = @event.eventsponsors.new(event_sponsor_params)
    if @event_sponsor.save
      flash[:success] = "Event sponsor added"
    else
      flash[:error] = "Unable to create event sponsor"
    end
  end

  def edit
    @event_sponsor = @event.eventsponsors.find_by(id: params[:id])
  end

  def update
    @event_sponsor = @event.eventsponsors.find_by(id: params[:id])
    if @event_sponsor.update(event_sponsor_params)
      flash[:success] = "Event sponsor updated"
    else
      flash[:error] = "Unable to update event sponsor"
    end
  end

  def destroy
    event_sponsor = @event.eventsponsors.find_by(id: params[:id])
    event_sponsor.destroy
    flash[:success] = "Event sponsor deleted"
  end

  private

  def event_sponsor_params
    params.require(:eventsponsor).permit(:name, :logo, :url, :level, :summary)
  end

  def all_sponsors
    @event_sponsors = @event.eventsponsors.group_by(&:level)
  end

  def find_event
    @event = Event.find_by(id: params[:event_id])
  end
end
