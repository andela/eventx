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
    head :no_content unless params[:token] && params[:provider]
    token = params[:token]
    provider = params[:provider]
    response = HTTParty.get(ENV[provider],
                            headers: { "Access_token"  => token,
                                       "Authorization" => "OAuth #{token}" })
    userinfo = JSON.parse(response.body) if response.code == 200
    create_auth_obj(userinfo)
    @user = User.from_omniauth(userinfo) if userinfo
    api_key = @user.generate_auth_token if @user
    render json: api_key.to_json || { error: "Invalid credentials" }
  end

  def destroy
    session[:user_id] = nil
    session[:url] = nil
    redirect_to root_url
  end

  # private

  # def create_auth_obj
  # end
  #
  # def oauth_url(provider)
  #   oauth_url = {}
  #   oauth_url["google"] = "https://www.googleapis.com/oauth2/v2/userinfo"
  #   fields = "fields=id,name,email,picture"
  #   oauth_url["facebook"] = "https://graph.facebook.com/me?#{fields}"
  #   t_fields = "status=false,include_email=true"
  #   twitter = "https://api.twitter.com/1.1/account/verify_credentials.json"
  #   oauth_url["twitter"] = twitter
  #   oauth_url["github"] = "https://api.github.com/user"
  # end
end
