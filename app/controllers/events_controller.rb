class EventsController < ApplicationController
  before_action :authenticate_user, except: [:show, :index]
  before_action :authorize_user_create, only: [:new, :create]
  before_action :authorize_user_manage, only: [:edit, :update]
  before_action :set_events, only:  [:show, :edit, :update, :enable, :disable ]

  respond_to :html, :json, :js

  def new
    @event = Event.new.decorate
    @event.ticket_types.build
    @roles = Event.get_roles
  end

  def index
    @categories = Category.all
    @events = Event.find_event(search_params)
    @events = [] if @events.nil?
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
    @roles = Event.get_roles
  end

  def enable
    @event.enabled = true
    @event.save(validate: false)
    redirect_to :back
  end

  def disable
    @event.enabled = false
    @event.save(validate: false)
    redirect_to :back
  end

  def update
    @event.event_staffs.delete_all
    flash[:notice] = if @event.update(event_params)
                       "Your Event was successfully updated"
                     else
                       @event.errors.full_messages.join("; ")
                     end
    respond_with(@event)
  end

  def create
    @roles = Event.get_roles
    @event = Event.new(event_params).decorate
    @event.manager_profile = current_user.manager_profile
    @event.title = @event.title.strip
    flash[:notice] = if @event.save
                       "Your Event was successfully created."
                     else
                       @event.errors.full_messages.join("; ")
                     end
    respond_with(@event)
  end

  

  private

  def search_params
    params.permit(:event_name, :event_location, :event_date, :category_id,
                  :enabled)
  end

  def event_params
    params.require(:event).permit(:title, :description, :start_date,
                                  :end_date, :category_id, :location, :venue,
                                  :image, :template_id, :map_url,
                                  :event_template_id,
                                  ticket_types_attributes:
                                    [:id, :_destroy, :name, :quantity, :price],
                                  event_staffs_attributes:
                                    [:user_id, :role])
  end

  def set_events
    @event = Event.find_by_id(params[:id])
    if @event.nil?
      flash[:notice] = "Event not found"
      redirect_to :back
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
