class AttendeesController < ApplicationController
  respond_to :js
  before_action :find_event
  def create
    @attendee = @event.attendees.build(user_id: current_user.id)
    if @attendee.save

    else

    end
  end

  def destroy
    @event.attendees.destroy(user_id: current_user)
    flash[:error] = "You have successfully unattend this event"
    redirect_to :back
  end

  private

  def attend_params
   params.permit(:user_id, :event_id )
  end
  def find_event
    @event = Event.find(params[:event_id])
  end
end
