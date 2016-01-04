class AttendeesController < ApplicationController
  before_action :find_event

  def destroy
    @attendee = current_user.bookings.find_by_event_id(@event.id)
    if @attendee.destroy
      flash[:notice] = "You have successfully unattended this event"
    else
      flash[:notice] = "An error occurred"
    end
  end

  private

  def attend_params
    params.permit(:user_id, :event_id)
  end

  def find_event
    @event = Event.find(attend_params[:event_id])
  end
end
