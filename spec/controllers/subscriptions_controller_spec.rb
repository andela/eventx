require "rails_helper"

RSpec.describe SubscriptionsController, type: :request do
  before(:all) do
    create(:subscription)
    @event = create(:regular_event)
  end

  context "when event manager create's a new event" do
    it "should deliver email subscribers" do
      post "/events", event: attributes_for(:regular_event)
      expect(ActionMailer::Base.deliveries.size).to eq 1
    end
  end

  context "when event manager updates an event" do
    it "should diliver email to subscribers" do
      put "/events/#{@event.id}", attributes_for(:regular_event)
      expect(ActionMailer::Base.deliveries.size).to eq 1
    end
  end
end
