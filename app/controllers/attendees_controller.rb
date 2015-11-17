class AttendeesController < ApplicationController
  #respond_to :js
  before_action :find_event, :find_user

  def create
    @attendee = @event.attendees.build(user_id: current_user.id)
    if @attendee.save
      #sends an email to the attendee of the event
      EventMailer.attendance_confirmation(@user, @event).deliver_later!(wait: 1.minute)
    else
      #@create2 = false
    end
  end

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
      @event = Event.find(params[:event_id])
    end
    def find_user
       @user = User.find(current_user.id)
    end
end
