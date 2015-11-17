class ManagerProfilesController < ApplicationController
  before_action :authenticate_user

  def create
    @manager_profile = ManagerProfile.new(manager_profile_params)
    @manager_profile.user_id = current_user.id
    if @manager_profile.save
      flash[:success] = "You can now create and manage events."
      path = request.base_url.gsub("http://",
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

  private
    def manager_profile_params
      params.require(:manager_profile).permit(:company_name, :company_mail, :company_phone, :subdomain)
    end
end
