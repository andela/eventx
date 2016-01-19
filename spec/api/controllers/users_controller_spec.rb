require "rails_helper"

RSpec.describe UsersController, type: :controller do
  before do
    user = FactoryGirl.create(:user)
    manager = FactoryGirl.create(:manager_profile, user: user)
    session[:user_id] = user.id
    api_key = user.generate_auth_token
    request.headers["Authorization"] = "#{api_key}"
    FactoryGirl.create(:event, manager_profile: manager)
  end

  describe "#show" do
    it "should return event created by current_user" do
      get :show, format: "json"
      expect(response.status).to eq 200
      expect(json).not_to be nil
      expect(json.count).to eq 1
    end
  end
end
