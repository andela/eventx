require "rails_helper"

RSpec.describe WelcomeController, type: :controller do
  before do
    user = FactoryGirl.create(:user)
    @manager_profile = FactoryGirl.create(:manager_profile, user: user)
    session[:user_id] = user.id
    FactoryGirl.create(:event, manager_profile: @manager_profile)
  end

  describe "#featured" do
    it "should return json format of featured_events" do
      get :featured, format: "json"
      expect(response.status).to eq 200
      content_type = response.header["Content-Type"]
      expect(content_type).to include "json"
    end
  end

  describe "#index" do
    it "should return json format of all events" do
      get :index, format: "json"
      expect(response.status).to eq 200
      content_type = response.header["Content-Type"]
      expect(content_type).to include "json"
      expect(json).not_to be_nil
    end
  end

  describe "#popular" do
    it "should return json format of popular_events" do
      get :popular, format: "json"
      expect(response.status).to eq 200
      content_type = response.header["Content-Type"]
      expect(content_type).to include "json"
    end
  end
end
