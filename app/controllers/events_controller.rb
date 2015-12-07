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
    @events = Event.recent_events
    @categories = Category.all
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
      elsif params[:category_id]
        @events = Event.where(category_id: params[:category_id])
      end
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
    msg = "Your Event was successfully updated"
    err = "Your Event was not updated"
    flash[:notice] = msg if @event.update(event_params)
    flash[:notice] = err unless @event.update(event_params)
    respond_with(@event)
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
