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
  before_action :subscription_status, only: [:show]

  layout "admin", only: [:tickets, :tickets_report]

  respond_to :html, :json, :js

  def new
    @event = Event.new.decorate
    @event.ticket_types.build
    @roles = Event.get_roles
  end

  def show_domain
    @event = Event.find_by(subdomain: request.subdomain).decorate
    set_event_attributes
    render "show"
  end

  def index
    @categories = Category.list
    @events = Event.find_event(search_params)
    @events = [] if @events.nil?
    respond_with @events
  end

  def show
    set_event_attributes
    if @event.subdomain.blank?
      render "show"
    else
      redirect_to event_subdomain_url(subdomain: @event.subdomain)
    end
  end

  def edit
    @roles = Event.get_roles
    @highlights = @event.highlights
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
                       update_successful_message("event")
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
                       send_staff_invites(@event)
                       create_successful_message("event")
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
                  notice: no_popular_event
    else
      @popular_events = Event.popular_by_categories(params[:category])
    end
  end

  private

  def set_event_attributes
    @booking = @event.bookings.new
    @booking.user = current_user
    @event_ticket = @event.ticket_types
    1.times { @booking.user_tickets.build }
  end

  def search_params
    params.permit(:event_name, :event_location, :event_date, :category_id,
                  :enabled)
  end

  def event_params
    params.require(:event).permit(
      :title, :description, :start_date, :end_date, :category_id, :location,
      :venue, :image, :template_id, :map_url, :event_template_id, :subdomain,
      ticket_types_attributes: [:id, :_destroy, :name, :quantity, :price],
      highlights_attributes:   [:id, :_destroy, :day, :title, :description,
                                :start_time, :end_time, :image, :image_title],
      invites_attributes: [:email, :role, :sender_id]
    )
  end

  def set_events
    @event = Event.find(params[:id])
    if @event.nil?
      flash[:notice] = event_not_found
      redirect_to :back
    else
      @event = @event.decorate
    end
  end

  def set_sponsor
    @sponsors = @event.sponsors.group_by(&:level) if @event
  end

  def subscription_status
    @subscribed = Subscription.find_by(
      event_id: @event.id,
      user_id: current_user.id
    ) if current_user
  end

  def send_staff_invites(event)
    @invites = event.invites
    @invites.each do |invite|
      send_invite_to_new_or_existing_users(invite)
    end
  end

  def send_invite_to_new_or_existing_users(invite)
    if invite.recipient
      send_existing_staff_invite(invite)
    end
  end

  def send_existing_staff_invite(invite)
    mail = EventMailer.staff_invitation(invite)
    mail.deliver_now
  end

  def loading
  end
end
