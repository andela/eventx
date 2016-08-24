
RSpec.describe WelcomeController, type: :controller do
  describe "#popular" do
    before do
      event = create(:event, manager_profile: create(:manager_profile))
      event.bookings << create(:booking)
    end

    it "should return all popular events" do
      get :popular
      expect(response).to render_template "welcome/events_list"
    end

    it "should respond with a 200 status code" do
      get :popular
      expect(response.status).to eq(200)
    end
  end

  describe "GET index" do
    it "should respond with a 200 status code" do
      get :index
      expect(response.status).to eq(200)
    end

    it "should return all recent events" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "GET featured" do
    it "should respond with a 200 status code" do
      get :featured
      expect(response.status).to eq(200)
    end

    it "should return all featured events" do
      get :featured
      expect(response).to render_template "welcome/events_list"
    end
  end
end
