class PrinterController < ApplicationController
  before_action :authenticate_user, :get_booking

  def print
    render pdf: "print", layout: "pdf.html.erb"
  end

  def redirect_to_print
    redirect_to print_path(
      booking_id: params[:booking_id],
      ticket_type_id: params[:ticket_type_id]
    )
  end

  def download
    html = render_to_string("print", layout: "pdf.html.erb")
    pdf = WickedPdf.new.pdf_from_string(html)
    send_data(pdf, filename: "#{@event.title.downcase}.pdf")
  end

  private

  def get_booking
    booking = current_user.bookings.find_by(id: params[:booking_id])
    if booking.nil?
      flash[:notice] = "Booking not found"
      redirect_to tickets_path
    else
      set_tickets(booking)
    end
  end

  def set_tickets(booking)
    @event = booking.event
    @user_tickets = booking.user_tickets
    if params[:ticket_type_id]
      id = params[:ticket_type_id]
      @user_tickets = @user_tickets.where(ticket_type_id: id)
    end
  end
end
