class SponsorsController < ApplicationController
  before_action :find_event
  before_action :all_sponsors
  respond_to :html, :js

  def index
    @sponsors = @event.sponsors.group_by(&:level)
  end

  def new
    @sponsor = @event.sponsors.new
  end

  def create
    @sponsor = @event.sponsors.new(sponsor_params)
    if @sponsor.save
      flash[:success] = "Event sponsor added"
    else
      flash[:error] = "Unable to create event sponsor"
    end
  end

  def edit
    @sponsor = @event.sponsors.find_by(id: params[:id])
  end

  def update
    @sponsor = @event.sponsors.find_by(id: params[:id])
    if @sponsor.update(sponsor_params)
      flash[:success] = "Event sponsor updated"
    else
      flash[:error] = "Unable to update event sponsor"
    end
  end

  def destroy
    sponsor = @event.sponsors.find_by(id: params[:id])
    sponsor.destroy
    flash[:success] = "Event sponsor deleted"
  end

  private

  def sponsor_params
    params.require(:sponsor).permit(:name, :logo, :url, :level, :summary)
  end

  def all_sponsors
    @sponsors = @event.sponsors.group_by(&:level)
  end

  def find_event
    @event = Event.find_by(id: params[:event_id])
  end
end
