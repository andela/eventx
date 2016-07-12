class BookingsController < ApplicationController
  before_action :authenticate_user, except: [:paypal_hook]
  before_action :set_event, only: :each_event_ticket

  before_action except: [:paypal_hook, :index, :each_event_ticket,
                         :scan_ticket, :use_ticket, :request_refund,
                         :all_tickets, :grant_refund] do
    set_event
    ticket_params
    ticket_quantity_specified?
  end

  protect_from_forgery except: [:paypal_hook]
  respond_to :js, :hmtl, :json

  def event_titles
    @event_titles = Event.select("id, title").
                    where(manager_profile_id: current_user)
  end

  def index
    @bookings = current_user.bookings.order(id: :desc).decorate
  end

  def all_tickets
    @all_tickets = Booking.find(params[:id]).user_tickets.
                   where(transfered: false).decorate
  end

  def create
    @booking = Booking.create(event: @event, user: current_user)
    tickets = []
    ticket_params.each do |ticket_type_id, quantity|
      quantity.to_i.times do
        user = UserTicket.new(ticket_type_id: ticket_type_id, booking: @booking)
        tickets << user
      end
    end
    UserTicket.import tickets
    @booking.save
    Booking.update_counters(@booking.id, user_tickets_count: tickets.size)
    process_free_ticket_or_redirect_paid_ticket
  end

  def paypal_hook
    params.permit!
    status = params[:payment_status]
    if status == "Completed"
      response = validate_ipn_notification(request.raw_post)
      examine_booking(response)
    end
    redirect_to bookings_path
  end

  def scan_ticket
    ticket = UserTicket.find_by(ticket_number: params[:ticket_no])
    flash[:notice] = ticket_invalid unless ticket
    @user_ticket = ticket ? ticket.decorate : ticket
  end

  def request_refund
    @booking = Booking.find_by_uniq_id(params[:uniq_id])
    unless @booking.refund_requested
      @booking.update_attributes(
        refund_requested: true,
        time_requested: Time.now,
        reason: params[:reason]
      )
    end
  end

  def grant_refund
    @booking = Booking.find_by(uniq_id: params[:uniq_id])
    data = {
      granted: true, granted_by: current_user.id, time_granted: Time.now
    }
    flash[:notice] = if @booking.granted
                       duplicate_refund_request
                     else
                       update_booking data
                     end
    redirect_to "/events/#{@booking.event.id}/tickets-report"
  end

  def update_booking(data)
    if @booking.update_attributes(data)
      grant_refund_success
    else
      grant_refund_failure
    end
  end

  def use_ticket
    ticket_no = params[:ticket_no]
    @user_ticket = UserTicket.find_by(ticket_number: ticket_no).decorate
    if @user_ticket.is_used
      flash[:notice] = ticket_used
    else
      @user_ticket.update_attributes(
        is_used: true,
        time_used: Time.now,
        scanned_by: current_user
      )
    end
    render :scan_ticket
  end

  private

  def ticket_params
    params.require(:tickets_quantity)
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def process_free_ticket_or_redirect_paid_ticket
    if @booking.amount == 0
      @booking.free!
      trigger_booking_mail
      redirect_to bookings_path
    else
      redirect_to @booking.paypal_url(paypal_hook_path)
    end
  end

  def validate_ipn_notification(raw)
    uri = URI.parse(Booking.validate_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.open_timeout = 60
    http.read_timeout = 60
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    http.use_ssl = true
    http.post(uri.request_uri, raw,
              "Content-Length" => raw.size.to_s,
              "User-Agent" => "EventX"
             ).body
  end

  def examine_booking(response)
    case response
    when "VERIFIED"
      @booking = Booking.find_by_uniq_id(params[:invoice])
      booking_accepted(@booking) if @booking
    when "INVALID"
    end
  end

  def ticket_quantity_specified?
    if ticket_params.values.map(&:to_i).inject(:+) <= 0
      flash[:notice] = ticket_quantity_empty
      redirect_to :back
    else
      ticket_params.each do |key, value|
        tickets_left = @event.ticket_types.find(key).tickets_left
        next unless tickets_left < value.to_i
        flash[:notice] = ticket_quantity_exeeded
        redirect_to :back
      end
    end
  end

  def booking_accepted(booking)
    booking.paid!
    booking.update(txn_id: params[:txn_id])
    trigger_booking_mail
  end

  def trigger_booking_mail
    user = @booking.user
    event = @booking.event
    mail = EventMailer.attendance_confirmation(user, event)
    mail.deliver_later!(wait: 1.minute)
  end
end
