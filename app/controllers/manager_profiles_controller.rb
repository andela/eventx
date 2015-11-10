class ManagerProfilesController < ApplicationController
  def create
   @manager_profiles = ManagerProfile.create(create_params)
   @manager_profiles.user_id = current_user.id
   if @manager_profiles.save
    flash[:success] = "You are now a manager"
    redirect_to(root_path)
  else
    flash[:notice] = "Incorrect entry entered ?"
    render :new
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
