class RemitController < ApplicationController
  before_action :remit_exist

  def new
    @event = Event.find_by(id: params[:id])
    @manager = @event.manager_profile
    @remit = @event.build_remit

    unless @remit.save
      redirect_to dashboard_path,
                  notice: "Event cannot yet request a remittance!"
    end
  end

  private

  def remit_exist
    if Remit.find_by(event_id: params[:id])
      redirect_to dashboard_path,
                  notice: "This event remit have already been processed"
    end
  end
end
