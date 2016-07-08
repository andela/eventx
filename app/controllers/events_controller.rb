class EventsController < ApplicationController
  load_and_authorize_resource class: "Event"
  before_action :authenticate_user, except: [:show, :index]
  before_action :set_events, only:  [
    :show,
    :edit,
    :update,
    :enable,
    :disable,
    :generate,
    :scan,
    :tickets_report
  ]
  before_action :set_sponsor

  respond_to :html, :json, :js

  def new
    @event = Event.new.decorate
    @event.ticket_types.build
    @roles = Event.get_roles
  end

  def index
    @categories = Category.list
    @events = Event.find_event(search_params)
    @events = [] if @events.nil?
    respond_with @events
  end

  def show
    @booking = @event.bookings.new
    @booking.user = current_user
    @highlights = @event.highlights.decorate
    @event_ticket = @event.ticket_types
    @reviews = @event.reviews
    1.times { @booking.user_tickets.build }
    respond_with @event
  end

  def edit
    @roles = Event.get_roles
    @highlights = @event.highlights.decorate
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

  def scan
  end

  def update
    @roles = Event.get_roles
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

  def tickets
    @bookings = current_user.user_tickets_for_event(params[:id])
  end

  def tickets_report
    @presenter = Events::TicketsReportPresenter.new(@event)
  end

  def generate
    calendar = @event.calendar
    headers["Content-Type"] = "text/calendar; charset=UTF-8;"
    headers["Content-Disposition"] = "attachment;" \
        "filename = #{@event.title.tr(' ', '_')}.ics"
    render text: calendar.to_ical
  end

  def popular
    if params[:category]
      popular_events_by_category
    else
      @popular_events = Event.popular_events
    end
  end

  def popular_events_by_category
    events_category = Event.popular_events_category(params[:category]).empty?
    if params[:category] && events_category
      redirect_to popular_path,
                  notice: "This category does not have a popular event"
    else
      @popular_events = Event.popular_by_categories(params[:category])
    end
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
                                  highlights_attributes:
                                  [:id, :_destroy, :day, :title, :description,
                                   :start_time, :end_time, :image,
                                   :image_title],
                                  event_staffs_attributes:
                                    [:user_id, :role])
  end

  def set_events
    @event = Event.find(params[:id])
    if @event.nil?
      flash[:notice] = "Event not found"
      redirect_to :back
    else
      @event = @event.decorate
    end
  end

  def set_sponsor
    @sponsors = @event.sponsors.group_by(&:level) if @event
  end

  def loading
  end
end
