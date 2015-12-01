class EventsController < ApplicationController
  before_action :authenticate_user, only: [:new, :create]
  before_action :authorize_user_create, only: [:new, :create]
  before_action :authorize_user_manage, only: [:edit, :update]
  before_action :set_events, only:  [:show, :edit, :update]

  def new
    @event = Event.new
    @event.ticket_types.build
  end

  def index
    @events = Event.recent_events
    @categories = Category.all
    respond_to do |format|
      unless params.size == 0
        date = (params[:event_date].nil?) ? "" : params[:event_date]
        params[:event_date] = date
        location = (params[:event_location].nil?) ? "" : params[:event_location]
        params[:event_location] = location
        event_name = (params[:event_name].nil?) ? "" : params[:event_name]
        params[:event_name] = event_name
        if params[:category_id].nil?
          @events = Event.search(params[:event_name], params[:event_location],
                                 params[:event_date])
          renders(format, @events, :index)
        elsif params[:category_id]
          @events = Event.where(category_id: params[:category_id])
          renders(format, @events, :index)
        else
          renders(format, @events, :index)
        end
      end
    end
  end

  def show
    @booking = @event.bookings.new
    @booking.user = current_user
    @event_ticket = @event.ticket_types
    1.times { @booking.user_tickets.build }
    respond_to do |format|
      renders(format, @event)
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      updated = "Your Event was successfully updated"
      redirect_to user_path(current_user.id), notice: "#{updated}"
    else
      redirect_to :back
    end
  end

  def create
    @event = Event.new(event_params)
    @event.manager_profile = current_user.manager_profile
    @event.title = @event.title.strip
    respond_to do |format|
      if @event.save
        @event.event_staffs.create(user: current_user).event_manager!
        flash[:id] = @event.id
        created = "Event was successfully created."
        format.html { redirect_to @event, notice: "#{created}" }
        format.json { render json: @event, status: 201 }
        format.xml
      else
        format.html do
          render :new, flash[:notice] = @event.errors.full_messages.join("<br>")
        end
        format.json { render json: @events.errors, status: 422 }
      end
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :start_date,
                                  :end_date, :category_id, :location, :venue,
                                  :image, :template_id, :map_url,
                                  :event_template_id, ticket_types_attributes:
                                  [:id, :_destroy, :name, :quantity, :price])
  end

  def renders(format, objects, page = nil)
    format.html { render page }
    format.json { render json: objects }
    format.js {}
  end

  def set_events
    @event = Event.find_by_id(params[:id])
    if @event.nil?
      flash[:notice] = "Event not found"
      redirect_to events_url
    else
      @event = @event.decorate
    end
  end

  def loading
  end

  def authorize_user_create
    unless can? :manage, Event
      flash[:notice] = "You need to be an event manager"
      redirect_to(root_path)
    end
  end

  def authorize_user_manage
    unless can? :update, Event
      flash[:notice] = "You need to be a staff of this event"
      redirect_to(root_path)
    end
  end
end
