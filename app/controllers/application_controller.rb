class ApplicationController < ActionController::Base
  before_action :check_domain
  helper_method :current_user
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end

  def no_route_found
    flash[:notice] = "Invalid address!"
    redirect_to root_path
  end

  def check_domain
    subdomain = modify(request.subdomain)
    excluded_subdomains = %w[eventx admin www event]
    unless subdomain.empty? || excluded_subdomains.include?(subdomain)
      set_tenant subdomain
    end
  end

  protected

  def record_not_found(exception)
    flash[:notice] = exception.message.to_s
    redirect_to root_path
  end

  def modify(name)
    name.match(/\A([a-zA-Z]+)/).to_s
  end

  def error_occurred(exception)
    flash[:notice] = exception.message.to_s
    redirect_to root_path
  end

  def set_tenant(subdomain)
    manager = ManagerProfile.find_by(subdomain: subdomain)
    if manager.nil?
      flash[:info] = "Subdomain does not exist"
      render file: "public/custom_404.html", layout: false
    end
    ActsAsTenant.current_tenant = manager
  end

  def authenticate_user
    unless current_user
      flash[:notice] = "You need to log in"
      redirect_to(root_path)
    end
  end
end
