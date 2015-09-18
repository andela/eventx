class BookingsController < ApplicationController
before_action :set_event
# skip_before_filter :verify_authenticity_token

  def create
    # require 'pry' ; binding.pry
    uniq_id = SecureRandom.hex
    puts params
    # tickets = @event.ticket_types
    # tickets.build(ticket_params)
    # ticket.update_all(uniq_id)
    #.user_tickets
    # ticket.paypal_url(event_path(params[:event]))
    # redirect_to
  end

  private
    # def ticket_params
    #   params.require(:ticket)
    # end

    def set_event
      @event = Event.find(params[:event_id])
    end

    def paypal_url()
      values = {
          business: ENV['PAYPAL_BUSINESS'],
          cmd: "_xclick",
          return: "#{ENV['app_host']}#{return_path}",
          invoice: ticket_number,
          amount: ticket_type.price,
          item_name: ticket_type.event.title,
          item_number: id,
          quantity: 1,
          notify_url: "#{ENV['paypal_notify_url']}/hook",
          ticket_types: params[:tickets]
      }
      "#{ENV['paypal_host']}/cgi-bin/webscr?" + values.to_query
    end
end
