class SessionsController < ApplicationController

  def create
    user = User.from_omniauth(env['omniauth.auth'])
    session[:user_id] = user.id
    if session[:url]
      redirect_to session[:url]
    else
      redirect_to root_url
    end
  end

  def destroy
    session[:user_id] = nil
    session[:url] = nil
    redirect_to root_url
  end
end
