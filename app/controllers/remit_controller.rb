class RemitController < ApplicationController
  def new
    @event = Event.find_by(id: params[:id])
    @manager = @event.manager_profile
    @remit = @event.build_remit
    if @remit.save
      @remit
    else
      flash[:notice] = "Event cannot yet request a remittance!"
      redirect_to my_events_path
    end
  end
end
