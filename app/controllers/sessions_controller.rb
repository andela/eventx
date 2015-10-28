class SessionsController < ApplicationController
  respond_to :js, :html

  def create
    user = User.from_omniauth(env['omniauth.auth'])
    session[:user_id] = user.id
    if env['omniauth.origin'].nil?
      redirect_to root_url
    else
      redirect_to env['omniauth.origin']
    end
  end

  def destroy
    session[:user_id] = nil
    session[:url] = nil
    redirect_to root_url
  end

  # def create
  #   user = User.from_omniauth(env['omniauth.auth'])
  #   if env['omniauth.origin'].nil?
  #     # session[:user_id] = user.id
  #       cookies[:user_id] = { value: user.id, domain: ".127.0.0.1.xip.io" }
  #       redirect_to root_url
  #   else
  #       redirect_to env['omniauth.origin']
  #   end
  # end
  #
  # def destroy
  #   #session[:user_id] = nil
  #   cookies.delete(:user_id, :domain => '.127.0.0.1.xip.io')
  #   redirect_to root_url
  # end
end
