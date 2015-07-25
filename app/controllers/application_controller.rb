class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  @categories = {tunde: 1, ore: 2, kay: 3, gibbs: 4}
  @val = 1
  helper_method :current_user
  protect_from_forgery with: :exception


  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def redirect_to_user_sign_in
    redirect_to root_path if !current_user
  end
end
