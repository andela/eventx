class EventsController < ApplicationController
  before_action :authenticate_user, :only => [:new, :create, :edit]
  before_action :set_events, :only => [:show, :edit, :update]


  def new
    @event = Event.new
    @event.build_ticket
  end

  def index
    @events = Event.recent_events
    @categories = Category.all
  end

  def show
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to user_path(current_user.id), notice: 'Your Event was successfully updated'
    else
      redirect_to :back
    end
  end

  def create
    @event = Event.new(event_params)
    #  @event.user_id = current_user.id
     @event.event_manager = current_user
    if @event.save
      flash[:id] = @event.id
      respond_to do |format|
        format.html {redirect_to @event, notice: 'Event was successfully created.'}
        format.json
        format.xml
      end
    else
      render :new
    end
  end

  private
    def event_params
      # require 'pry' ; binding.pry
      params.require(:event).permit(:title, :description, :start_date, :end_date,
                                    :category_id, :location, :venue, :image, :template_id,
                                    :map_url, :event_template_id,
                                    ticket_attributes: [ :name, :quantity, :price ])
    end

  def set_events
    @event = Event.find(params[:id]).decorate
    @event.user_id = current_user
  end

  def loading

  end
end
