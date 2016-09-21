class BookingMailer < ApplicationMailer
  def request_refund(booking, host)
    @host = host
    @booking = booking
    @user = booking.user
    @event = booking.event
    @manager = booking.event.manager_profile
    @title = "New Request for Refund"
    mail(to: @manager.company_mail, subject: "New Request for Refund")
  end

  def grant_refund(booking, host)
    @host = host
    @booking = booking
    @user = booking.user
    @event = booking.event
    @manager = booking.event.manager_profile
    @title = "Your Request for Refund has been Granted"
    mail(to: @user.email, subject: "Your Request for Refund has been Granted")
  end

end
