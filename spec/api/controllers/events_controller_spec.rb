require "rails_helper"

RSpec.describe EventsController, type: :controller do
  before do
    user = create(:user)
    @manager_profile = create(:manager_profile, user: user)
    session[:user_id] = user.id
    api_key = user.generate_auth_token
    request.headers["Authorization"] = api_key.to_s
  end

  let(:event) do
    attributes_for(:event,
                   ticket_types_attributes:
                   [attributes_for(:ticket_type_free)])
end

  describe "#create" do
    it "should allow Api user to create an event" do
      params = { event: event }
      post :create, params
      expect(assigns(:event)).to be_a(Event)
      expect(assigns(:event)).to be_persisted
      expect(Event.all.count).to be 1
    end

    it "should not allow Api user to create an invalid event" do
      params = { event: nil }
      error_expected = ActionController::ParameterMissing
      expect { post :create, params }.to raise_error(error_expected)
      expect(Event.all.count).not_to be 1
    end
  end

  describe "#update" do
    it "should allow Api user to edit an event" do
      create(:event, manager_profile: @manager_profile)
      first_event = Event.first
      expect(first_event.title).to eq "Blessings wedding"
      edited_event = attributes_for(:tomorrow_event)
      put :update, id: first_event.to_param, event: edited_event
      edited_event_title = Event.first.title
      expect(edited_event_title).not_to eq "Blessings wedding"
      expect(edited_event_title).to eq "Tomorrow Event"
    end
  end

  describe "without authorization" do
    it "should not create event without authorization" do
      session[:user_id] = nil
      request.headers["Authorization"] = nil
      params = { event: event }
      post :create, params, format: :json
      expect(response.status).to eq 302
    end
  end
end
