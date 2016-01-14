class AttendeesController < ApplicationController
  before_action :find_event

  # def create
  #   @attendee = @event.attendees.build(user_id: current_user.id)
  #   if @attendee.save
  #     event = EventMailer.attendance_confirmation(@user, @event)
  #     event.deliver_later!(wait: 1.minute)
  #   end
  # end

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

  # def find_user
  #   @user = User.find(current_user.id)
  # end
end
