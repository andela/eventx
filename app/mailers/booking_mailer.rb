class BookingMailer < ApplicationMailer
  def request_refund(booking)
    @booking = booking
    @user = booking.user
    @event = booking.event
    @manager = booking.event.manager_profile
    mail(to: @manager.company_mail, subject: "New Request for Refund")
  end
end
