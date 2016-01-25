class ManagerProfilesController < ApplicationController
  before_action :authenticate_user

  def create
    @manager_profile = ManagerProfile.new(manager_profile_params)
    @manager_profile.user_id = current_user.id
    if @manager_profile.save
      flash[:success] = "You can now create and manage events."
      path = request.base_url.gsub(%r((http:\/\/www.)|(www.)|(http:\/\/)),
                                   "http://#{@manager_profile.subdomain}.")
      redirect_to(path)
    else
      flash[:notice] = "Found Errors in form submitted!"
      render :new
    end
  end

  def new
    @manager_profile = ManagerProfile.new
  end

  def event_staffs
    @event = Event.find_by_id(params[:event_id])
    if @event
      @event_staffs = @event.event_staffs.new
    else
      flash[:notice] = @event.errors.full_messages.join("<br />")
    end
  end

  def manage_staffs
  end

  private

  def manager_profile_params
    params.require(:manager_profile).permit(:company_name, :company_mail,
                                            :company_phone, :subdomain)
  end
end
