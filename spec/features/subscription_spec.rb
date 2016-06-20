require "rails_helper"

RSpec.describe "Subscription", type: :feature, js: true do
  before(:all) do
    Capybara.current_driver = :selenium
    ManagerProfile.destroy_all
    @event = create(:regular_event)
  end

  after(:all) do
    Capybara.use_default_driver
  end

  before(:each) do
    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(@event.manager_profile.user)
  end

  scenario "when subscribing for an event" do
    visit "/events/#{@event.id}"

    # click_button "Subscribe"
    find_button("subscribeBtn").trigger("click")
    expect(page).to have_content "SUBSCRIBE"
    find_button("btn_subscribe").trigger("click")
    # click_button "Subscribe"

    expect(page).to have_content "You been subscribed to this event"
  end
end
