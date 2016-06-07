require "rails_helper"

RSpec.describe "Subscription", js: true do
  before(:all) do
    ManagerProfile.destroy_all
    @event = create(:regular_event)
  end

  before(:each) do
    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(@event.manager_profile.user)
  end

  scenario "when subscribing for an event", js: true do
    visit "/events/#{@event.id}"

    click_link "Subscribe"
    expect(page).to have_content "SUBSCRIBE"
    click_button "Subscribe"

    expect(page).to have_content "You been subscribed to this event"
  end
end
