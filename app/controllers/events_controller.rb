class EventsController < ApplicationController
  #filters
  before_action :authenticate_user, :only => [:new, :create]
  before_action :set_events, :only => [:show]

  def new
    @events = Event.new
    @events.build_ticket
  end

  def index

    @events = Event.recent_events
    @categories = Category.all
  end

  def show
  end

  def create
    @events = Event.new(event_params)
    @events.user_id = current_user
    if @events.save
      flash[:id] = @events.id
      respond_to do |format|
        format.html {redirect_to events_new_path+'#test3', notice: 'Event was successfully created'}
        format.json
        format.xml
      end
    else
      render :new
    end
  end

  private
    def event_params
      params.require(:event).permit(:title, :description, :start_date, :end_date,
                                    :category_id, :location, :venue, :image, :template_id,
                                    :map_url, :event_template_id,
                                    ticket_attributes: [ :name, :quantity, :price ])
    end

  def set_events
    @event = Event.find(params[:id])
  end

  def loading

  end
end
