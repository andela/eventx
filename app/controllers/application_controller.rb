class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  helper_method :current_user
  protect_from_forgery with: :exception


  @color = "red"
  #private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # rescue_from ::ActiveRecord::RecordNotFound, with: :record_not_found
  # rescue_from ::NameError, with: :error_occurred
  # rescue_from ::ActionController::RoutingError, with: :no_route_found
  # rescue_from ::Exception, with: :error_occurred


  def no_route_found
    flash[:notice] = "Invalid address!"
    redirect_to root_path
  end

protected
  def record_not_found(exception)
    flash[:notice] = exception.message.to_s
    redirect_to root_path
  end


  def error_occurred(exception)
    flash[:notice] = exception.message.to_s
    redirect_to root_path
  end

   #authenticate users that are not logged in
  def authenticate_user
    unless current_user
      flash[:notice] = "You need to log in"
      redirect_to (:back || root_path)
    end
  end
end
