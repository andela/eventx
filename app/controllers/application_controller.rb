require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html, :json

  before_action :check_domain
  helper_method :current_user
  protect_from_forgery
  skip_before_action :verify_authenticity_token, if: :json_request?

  rescue_from NotAuthenticatedError do
    render json: {}, status: :unauthorized
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:notice] = exception.message
    redirect_to root_path
  end

  def current_user
    if decoded_auth_token
      @current_user ||= User.find_by_id(decoded_auth_token["user_id"])
    elsif session[:user_id]
      @current_user ||= User.find_by_id(session[:user_id])
    end
  end

  def current_ability
    @current_ability ||= Ability.new(current_user)
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

  def modify(name)
    name.match(/\A([a-zA-Z]+)/).to_s
  end

  def json_request?
    request.format.json?
  end

  def set_tenant(subdomain)
    manager = ManagerProfile.find_by(subdomain: subdomain)
    if manager.nil?
      flash[:info] = "Subdomain does not exist"
      render file: "public/custom_404.html", layout: false
    end
    ActsAsTenant.current_tenant = manager
  end

  def decoded_auth_token
    @decoded_auth_token ||= AuthToken.decode(http_auth_header)
  end

  def http_auth_header
    if request.headers["Authorization"].present?
      return request.headers["Authorization"].split(" ").last
    end
  end

  def authenticate_user
    unless current_user
      respond_to do |format|
        format.html do
          redirect_to(root_path)
          flash[:notice] = "You need to log in"
        end
        format.json do
          fail NotAuthenticatedError
        end
      end
    end
  end
end
