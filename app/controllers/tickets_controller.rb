class TicketsController < ApplicationController
  def event_tickets
    @bookings = current_user.bookings.where(
      event: @event
    ).order(id: :desc).decorate
    render "index"
  end


end
