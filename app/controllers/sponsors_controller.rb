class SponsorsController < ApplicationController
  load_and_authorize_resource
  before_action :find_event, :all_sponsors
  before_action :find_sponsor, only: [:edit, :update, :destroy]
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
      flash[:success] = messages.sponsor_create_success
    else
      flash[:error] = messages.sponsor_create_error
    end
  end

  def edit
  end

  def update
    if @sponsor.update(sponsor_params)
      flash[:success] = messages.sponsor_update_success
    else
      flash[:error] = messages.sponsor_update_error
    end
  end

  def destroy
    @sponsor.destroy
    flash[:success] = messages.sponsor_delete_success
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

  def find_sponsor
    @sponsor = @event.sponsors.find_by(id: params[:id])
  end
end
