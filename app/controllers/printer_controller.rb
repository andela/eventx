class PrinterController < ApplicationController
  before_action :authenticate_user, :get_booking

  def print
    render pdf: "print", layout: "pdf.html.erb"
  end

  def download
    html = render_to_string("print", layout: "pdf.html.erb")
    pdf = WickedPdf.new.pdf_from_string(html)
    send_data(pdf, filename: "#{@booking.event.title.downcase}.pdf")
  end

  private

  def get_booking
    @booking = current_user.bookings.find_by(id: params[:booking_id])
    if @booking.nil?
      flash[:notice] = "Booking not found"
      redirect_to tickets_path
    else
      set_ticket_type
    end
  end

  def set_ticket_type
    user_tickets = @booking.user_tickets
    if params[:ticket_type_id]
      id = params[:ticket_type_id]
      user_tickets = user_tickets.where(ticket_type_id: id)
    end
    query = user_tickets.select(:ticket_type_id).group(:ticket_type_id).count
    @ticket_types = query
  end
end
