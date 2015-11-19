class BookingsController < ApplicationController
  before_action except: [:view_booking, :paypal_hook] do
    authenticate_user
    set_event
    ticket_params
    ticket_quantity_specified?
  end

  protect_from_forgery except: [:paypal_hook]

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
    render nothing: true
  end

  def view_booking
    if params[:item_number]
      booking = Booking.find(params[:item_number])
      redirect_to event_path(booking.event)
    else
      redirect_to events_path
    end
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
      redirect_to @booking.event
    else
      redirect_to @booking.paypal_url(view_booking_path)
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
              "Content-Length" => "#{raw.size}",
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
      flash[:notice] = "You have to specify quantity of ticket required!"
      redirect_to event_path(params[:event_id])
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
