require "rails_helper"

RSpec.describe SessionsController, type: :controller do
  before do
    DatabaseCleaner.strategy = :transaction
    OmniAuth.config.test_mode = true
  end
  describe "#create" do
    before do
      set_valid_omniauth
      request.env["omniauth.auth"] =  OmniAuth.config.mock_auth[:google_oauth2]
    end
    it "should successfully create a user" do
      expect {
        post :create, provider: :google_oauth2
      }.to change{ User.count }.by(1)
    end
    it "should successfully create a session" do
      expect(session[:user_id]).to be_nil
      post :create, provider: :google_oauth2
      expect(session[:user_id]).not_to be_nil
    end
    it "should redirect the user to the root url" do
      post :create, provider: :google_oauth2
      expect(response).to redirect_to root_url
    end
  end
  describe "#destroy" do
    before :each do
      set_valid_omniauth
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
    end
    it "should clear the session" do
      post :create, provider: :google_oauth2
      expect(session[:user_id]).not_to be_nil
      delete :destroy
      expect(session[:user_id]).to be_nil
      expect(response).to redirect_to root_url
    end
  end
end
