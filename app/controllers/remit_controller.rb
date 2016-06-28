class RemitController < ApplicationController
  before_action :remit_exist

  def new
    @event = Event.find_by(id: params[:id])
    @manager = @event.manager_profile
    @remit = @event.build_remit

    unless @remit.save
      redirect_to dashboard_path,
                  notice: messages.remit_not_due
    end
  end

  private

  def remit_exist
    if Remit.find_by(event_id: params[:id])
      redirect_to dashboard_path,
                  notice: messages.remit_duplicate_alert
    end
  end
end
