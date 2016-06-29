require "rails_helper"
RSpec.describe SessionsController, type: :controller do
  before do
    mock_httparty_request
  end

  describe "#api_login" do
    it "should supply api key when correct provider & token are supplied" do
      params = { provider: "facebook", token: "token" }
      allow(ENV).to receive(:[]).and_return(url)
      post :api_login, params
      expect(response.status).to eq 200
      expect(json["api_key"]).not_to eql nil
    end

    it "should log in user when correct params is passed" do
      params = { provider: "facebook", token: "token" }
      allow(ENV).to receive(:[]).and_return(url)
      post :api_login, params
      expect(session[:user_id]).not_to eql nil
    end

    it "should not supply api key for incorrect token" do
      mock_httparty_request("invalid_token")
      params = { provider: "facebook", token: "invalid token" }
      post :api_login, params
      expect(response.status).to eq 417
      expect(json["api_key"]).to eql invalid_token
    end

    it "should not supply api key for incorrect provider" do
      params = { provider: "invalid provider", token: "token" }
      post :api_login, params
      expect(response.status).to eq 417
      expect(json["api_key"]).to eql invalid_token
    end
  end

  describe "#destroy" do
    it "should log out api user from the session" do
      signin
      get :destroy
      expect(session[:user_id]).to eql nil
    end
  end
end
