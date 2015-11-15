class ManagerProfilesController < ApplicationController
  before_action :authenticate_user

  def create
    @manager = ManagerProfile.create(create_params)
    @manager.user_id = current_user.id
    if @manager.save
      flash[:success] = "You can now create and manage events."
      path = request.base_url.gsub("http://", "http://#{@manager.subdomain}.")
      redirect_to(path)
    else
      flash[:notice] = "Incorrect entry entered ?"
      render "new"
    end
  end

  def update
  end

  def edit
  end

  def new
    @manager_profiles = ManagerProfile.new
  end

  private

  def create_params
    params.require(:manager_profile).permit(:company_name, :company_mail, :company_phone, :subdomain)
  end
end
