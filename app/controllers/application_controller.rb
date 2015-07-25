class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  @categories = {tunde: 1, ore: 2, kay: 3, gibbs: 4}
  @val = 1
  helper_method :current_user, :sign_in_provider
  protect_from_forgery with: :exception


  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def redirect_to_user_sign_in
    redirect_to root_path if !current_user
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
end
