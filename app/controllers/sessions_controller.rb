class SessionsController < ApplicationController
  respond_to :js, :html

  def create
    auth = request.env["omniauth.auth"]
    user = User.from_omniauth(auth)
    session[:user_id] = user.id
    if env["omniauth.origin"].nil?
      redirect_to root_url
    else
      redirect_to env["omniauth.origin"]
    end
  end

  def destroy
    session[:user_id] = nil
    session[:url] = nil
    redirect_to root_url
  end
end
