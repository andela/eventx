class EventsController < ApplicationController

  before_action :authenticate_user, :only => [:new, :create]
  before_action :set_events, :only => [:show, :edit]

  def new
    @event = Event.new
    1.times{ @event.ticket_types.build }
    # @event.build_ticket_types
  end

  def index
    @events = Event.recent_events
    @categories = Category.all
    unless params.size==0
      params[:event_date] = (params[:event_date].nil?) ? "" : params[:event_date]
      params[:event_location] = (params[:event_location].nil?) ? "" : params[:event_location]
      params[:event_name] = (params[:event_name].nil?) ? "" : params[:event_name]
      @events = (params[:category_id].nil?) ? Event.search(params[:event_name], params[:event_location], params[:event_date]) : Event.where(category_id: params[:category_id])
      unless @events.nil?
        render :index
      end
    end


  end

  def show
    @user_tickets = @event.user_tickets.new
    @event.user_tickets.build
    @event_ticket = @event.ticket_types
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
      params.require(:event).permit(:title, :description, :start_date, :end_date,
                                    :category_id, :location, :venue, :image, :template_id,
                                    :map_url, :event_template_id,
                                    ticket_attributes: [ :name, :quantity, :price ])
    end

  def set_events
    @event = Event.find(params[:id]).decorate
  end

  def loading

  end
end
