class PrinterController < ApplicationController
  before_action :authenticate_user, :get_booking

  def print
    @ticket_types = @booking.user_tickets.group("ticket_type_id").count
  end

  def download
  end


  private

  def get_booking
    @booking = current_user.bookings.find_by(id: params[:booking_id])
    if @booking.nil?
      flash[:notice] = 'Booking not found'
      redirect_to tickets_path
    end
  end
end
