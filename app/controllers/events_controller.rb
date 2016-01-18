class EventsController < ApplicationController
  before_action :authenticate_user, only: [:new, :create]
  before_action :authorize_user_create, only: [:new, :create]
  before_action :authorize_user_manage, only: [:edit, :update]
  before_action :set_events, only:  [:show, :edit, :update]

  respond_to :html, :json, :js

  def new
    @event = Event.new
    @event.ticket_types.build
  end

  def index
    @categories = Category.all
    if search_params.size == 0
      @events = Event.recent_events
    else
      @events = Event.search(search_params.symbolize_keys)
    end
    respond_with @events
  end

  def show
    @booking = @event.bookings.new
    @booking.user = current_user
    @event_ticket = @event.ticket_types
    1.times { @booking.user_tickets.build }
    respond_with @event
  end

  def edit
  end

  def update
    if @event.update(event_params)
      flash[:notice] = "Your Event was successfully updated"
      respond_with(@event)
    else
      flash[:notice] = "Your Event was not updated"
      respond_with(@event)
    end
  end

  def create
    @event = Event.new(event_params)
    @event.manager_profile = current_user.manager_profile
    @event.title = @event.title.strip
    if @event.save
      @event.event_staffs.create(user: current_user).event_manager!
      flash[:notice] = "Your Event was successfully created."
    else
      flash[:notice] = @event.errors.full_messages.join("<br />")
    end
    respond_with(@event)
  end

  private

  def search_params
    params.permit(:event_name, :event_location, :event_date, :category_id)
  end

  def event_params
    params.require(:event).permit(:title, :description, :start_date,
                                  :end_date, :category_id, :location, :venue,
                                  :image, :template_id, :map_url,
                                  :event_template_id, ticket_types_attributes:
                                  [:id, :_destroy, :name, :quantity, :price])
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
