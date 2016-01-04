class SessionsController < ApplicationController
  respond_to :js, :html, :json

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

  def api_login
    if params["token"].blank? || params["provider"].blank?
      render json: {}, status: 417
    else
      token = params[:token]
      @provider = params[:provider]
      response = HTTParty.get(ENV[@provider],
                              headers: { "Access_token"  => token,
                                         "Authorization" => "OAuth #{token}" })
      userinfo = JSON.parse(response.body) if response.code == 200
      @user = User.from_omniauth(create_auth_obj(userinfo)) if userinfo
      api_key = @user.generate_auth_token if @user
      api_key ||= "Invalid token/provider supplied"
      render json: { api_key: api_key }
    end
  end

  def destroy
    session[:user_id] = nil
    session[:url] = nil
    redirect_to root_url
  end

  private

  def create_auth_obj(userinfo)
    auth = {}
    auth["provider"] = @provider
    auth["uid"] = userinfo["id"]
    @pic = userinfo["picture"] if @provider == "google_oauth2"
    @pic = userinfo["picture"]["url"] if @provider == "facebook"
    auth["info"] = { image: @pic,
                     email: userinfo["email"], name: userinfo["name"] }
    auth
  end
end
