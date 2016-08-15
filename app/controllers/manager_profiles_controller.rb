class ManagerProfilesController < ApplicationController
  before_action :authenticate_user
  before_action :managers_current_event
  layout "admin", only: :manage_staffs

  def create
    @manager_profile = ManagerProfile.new(manager_profile_params)
    @manager_profile.user_id = current_user.id
    if @manager_profile.save
      flash[:success] = manager_create_success
      path = request.base_url.gsub(%r((http:\/\/www.)|(www.)|(http:\/\/)),
                                   "http://#{@manager_profile.subdomain}.")
      redirect_to(path)
    else
      flash[:notice] = form_submission_error
      render :new
    end
  end

  def new
    @manager_profile = ManagerProfile.new
  end

  def save_staffs
    staff = @event.event_staffs.new(staff_params)
    begin
      staff.save
    rescue ActiveRecord::RecordNotUnique
      flash[:notice] = form_submission_error
    end
    flash[:success] = create_successful_message("event staff")
    redirect_to :manage_staffs
  end

  def remove_staff
    @event.event_staffs.find_by(id: params[:event_staff_id]).destroy
    flash[:notice] = delete_successful_message("event staff")
    redirect_to :manage_staffs
  end

  def manage_staffs
    @roles = Event.get_roles
  end

  private

  def managers_current_event
    @event ||= Event.find_by_id(params[:event_id])
  end

  def manager_profile_params
    params.require(:manager_profile).permit(:company_name, :company_mail,
                                            :company_phone, :subdomain)
  end

  def staff_params
    params.permit(:role, :user_id)
  end
end
