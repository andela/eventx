class BookingsController < ApplicationController
  before_action :set_event, except: [:view_booking, :paypal_hook]
  before_action :ticket_params, except: [:view_booking, :paypal_hook]
  protect_from_forgery except: [:paypal_hook]

  def create
    @booking = Booking.new(event: @event, user: current_user)
    @booking.save
    tickets = []
    ticket_params.each{ |ticket_type_id, quantity|
        quantity.to_i.times{
          tickets << UserTicket.new(ticket_type_id: ticket_type_id, booking: @booking)
        }
    }
    UserTicket.import tickets
    @booking.save
    Booking.update_counters(@booking.id, user_tickets_count: tickets.size)
    process_free_ticket_or_redirect_paid_ticket
  end

  def paypal_hook
    params.permit!
    status = params[:payment_status]
    if status == "Completed"
       response = validate_IPN_notification(request.raw_post)
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
        redirect_to @booking.event
      else
        redirect_to @booking.paypal_url(view_booking_path)
      end
    end

    def validate_IPN_notification(raw)
      uri = URI.parse(Booking.validate_url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.open_timeout = 60
      http.read_timeout = 60
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      http.use_ssl = true
      response = http.post(uri.request_uri, raw,
                           'Content-Length' => "#{raw.size}",
                           'User-Agent' => "EventX"
                         ).body
    end

    def examine_booking(response)
      case response
      when "VERIFIED"
        @booking = Booking.find_by_uniq_id(params[:invoice])
        booking_accepted(@booking) if @booking
        #create a logger for invalid bookings
      when "INVALID"

      else
        # trigger error mailer for investigation
      end
    end

    def booking_accepted(booking)
      booking.paid!
      booking.update(txn_id: params[:txn_id])
    end
end
