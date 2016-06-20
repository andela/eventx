require "rails_helper"

RSpec.describe "Subscription", type: :feature, js: true do
  before(:each) do
    @event = create(:regular_event)
  end

  before(:each) do
    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(@event.manager_profile.user)
  end

  scenario "when subscribing for an event" do
    visit "/events/#{@event.id}"

    find_button("subscribeBtn").trigger("click")
    find_button("btn_subscribe").trigger("click")
    wait_for_ajax

    expect(page).to have_content "You have been subscribed to this event"
  end

  scenario "when unsubscribing from an event" do
    create(
      :subscription,
      user_id: @event.manager_profile.user.id,
      event_id: @event.id
    )
    visit "/events/#{@event.id}"

    find_button("unsubscribeBtn").trigger("click")
    page.evaluate_script("window.confirm = function() { return true; }")
    wait_for_ajax

    expect(page).to have_content "You have unsubscribed from this event"
  end
end
