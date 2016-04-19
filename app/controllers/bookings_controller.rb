class BookingsController < ApplicationController
  before_action :authenticate_user,
                except: [:paypal_hook, :paypal_dummy]
  before_action :set_event, only: :each_event_ticket
  before_action except: [:paypal_hook, :index,
                         :paypal_dummy, :each_event_ticket] do
    set_event
    ticket_params
    ticket_quantity_specified?
  end

  protect_from_forgery except: [:paypal_hook]

  def event_titles
    @event_titles = Event.select("id, title").
                    where(manager_profile_id: current_user)
  end

  def index
    @bookings = current_user.user_tickets
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
    render nothing: true
  end

  def paypal_dummy
    redirect_to tickets_path
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
      redirect_to tickets_path
    else
      redirect_to @booking.paypal_url(paypal_dummy_path)
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
