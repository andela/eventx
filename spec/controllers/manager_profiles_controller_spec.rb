require "rails_helper"

RSpec.describe ManagerProfilesController, type: :controller do
  before do
    DatabaseCleaner.strategy = :transaction
    set_valid_omniauth
    OmniAuth.config.test_mode = true
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
  end

  describe "#create" do
    it "creates valid manager profile" do
      user = User.from_omniauth(request.env["omniauth.auth"])
      session[:user_id] = user.id
      profile = attributes_for(:manager_profile)
      post :create, manager_profile: profile
      expect(response).not_to redirect_to root_path
    end
    it "does not create invalid manager profile" do
      user = User.from_omniauth(request.env["omniauth.auth"])
      session[:user_id] = user.id
      profile = attributes_for(:manager_profile, subdomain: nil)
      post :create, manager_profile: profile
      expect(flash[:notice]).to eq "Found Errors in form submitted!"
      expect(response).to render_template :new
      session[:user_id] = nil
    end
  end
end
