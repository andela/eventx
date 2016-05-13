class EventsponsorsController < ApplicationController
  before_action :find_event

  def manage_sponsors
    @event_sponsors = @event.eventsponsors
    # respond_to { |format| format.js { render "index" } }
  end

  def create
    event_sponsor = @event.eventsponsors.new(event_sponsor_params)
    if event_sponsor.save
      flash[:success] = "Event sponsor added"
      redirect_to root_path
    else
      flash[:error] = "Unable to create event sponsor"
      redirect_to root_path
    end
  end

  def update
    event_sponsor = @event.eventsponsors.find_by(id: params[:id])
    if event_sponsor.update(event_sponsor_params)
      flash[:success] = "Event sponsor updated"
      redirect_to root_path
    else
      flash[:error] = "Unable to update event sponsor"
      redirect_to root_path
    end
  end

  def destroy
    event_sponsor = @event.eventsponsors.find_by(id: params[:id])
    event_sponsor.destroy
    flash[:success] = "Event sponsor deleted"
    redirect_to root_path
  end

  private

  def event_sponsor_params
    params.require(:eventsponsor).permit(:name, :logo, :url, :summary)
  end

  def find_event
    @event = Event.find_by(id: params[:event_id])
  end
end
