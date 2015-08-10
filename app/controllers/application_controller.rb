class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  helper_method :current_user, :sign_in_provider
  protect_from_forgery with: :exception


  #private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def sign_in_provider
    {
        facebook: {name: "Facebook", class: "blue darken-3", icon_class: "fa-facebook"},
        twitter: {name: "Twitter", class: "blue", icon_class: "fa-twitter"},
        google_oauth2: {name: "Google", class: "red darken-4", icon_class: "fa-google-plus"},
        linkedin: {name: "LinkedIn", class: "blue darken-4", icon_class: "fa-linkedin"},
        github: {name: "Github", class: "grey darken-4", icon_class: "fa-github"},
        tumblr: {name: "Tumblr", class: "blue-grey darken-3", icon_class: "fa-tumblr"}
    }
  end

 #authenticate users that are not logged in
  def authenticate_user
    unless current_user
      flash[:notice] = "You need to log in"
      redirect_to root_url
    end
  end


  rescue_from ::ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ::NameError, with: :error_occurred
  rescue_from ::ActionController::RoutingError, with: :error_occurred
  rescue_from ::Exception, with: :error_occurred


  #protected

  def record_not_found(exception)
    flash[:notice] = exception.message.to_s
    redirect_to root_url
  end

  def error_occurred(exception)
    flash[:notice] = exception.message.to_s
    redirect_to root_url
  end

  def no_route_found
    flash[:notice] = "Invalid address!"
    redirect_to root_url
  end
end
