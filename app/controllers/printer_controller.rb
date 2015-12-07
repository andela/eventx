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
      flash[:notice] = 'Booking not found'
      redirect_to tickets_path
    end
    set_ticket_type
  end

  def set_ticket_type
    @ticket_types = @booking.user_tickets
    if params[:ticket_type_id]
      id = params[:ticket_type_id]
      @ticket_types = @ticket_types.where(ticket_type_id: id)
    end
    @ticket_types = @ticket_types.group(:ticket_type_id).count
  end
end
