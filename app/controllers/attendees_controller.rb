class AttendeesController < ApplicationController
  #respond_to :js
  before_action :find_event
  def create
    @attendee = @event.attendees.build(user_id: current_user.id)
    if @attendee.save
      #@create2 = true
    else
      #@create2 = false
    end
  end

  def destroy
   @attendee = current_user.attendees.find_by_event_id(@event.id)
   if !@attendee.nil? && @attendee.destroy
     #flash[:notice] = "You have successfully unattend this event"
   else
     #flash[:notice] = "An error occurred"
   end
  end

  private

  def attend_params
   params.permit(:user_id, :event_id)
  end
  def find_event
    @event = Event.find(params[:event_id])
  end
end
