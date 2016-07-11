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
    token = params[:token]
    provider = params[:provider]
    if token.blank? || ENV[provider].nil?
      render_api_response(invalid_token, 417)
    else
      response = get_provider_uri(ENV[provider], token)
      userinfo = JSON.parse(response.body) if response.code == 200
      api_user = get_api_user(userinfo, provider) if userinfo
      api_key = api_user.generate_auth_token if api_user
      api_key ||= invalid_token
      get_api_response(api_key, api_user)
    end
  end

  def destroy
    session[:user_id] = nil
    session[:url] = nil
    redirect_to root_url
  end

  private

  def get_api_response(api_key, api_user)
    if api_key == invalid_token
      render_api_response(api_key, 417)
    else
      session[:user_id] = api_user.id
      render_api_response(api_key, 200)
    end
  end

  def render_api_response(api_key, status)
    render json: { api_key: api_key }, status: status
  end

  def get_api_user(userinfo, provider)
    User.from_omniauth(create_auth_obj(userinfo, provider))
  end

  def get_provider_uri(provider, token)
    HTTParty.get(provider, headers: { "Access_token"  => token,
                                      "Authorization" => "OAuth #{token}" })
  end

  def create_auth_obj(userinfo, provider)
    auth = {}
    auth["provider"] = provider
    auth["uid"] = userinfo["id"]
    pic = nil
    picture = userinfo["picture"] || {}
    pic = picture if provider == "google_oauth2"
    pic = picture["url"] if provider == "facebook"
    auth["info"] = { image: pic,
                     email: userinfo["email"], name: userinfo["name"] }
    auth
  end
end
