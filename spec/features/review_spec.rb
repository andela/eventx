require "rails_helper"

RSpec.describe "Reviews", type: :feature, js: true do
  before(:all) do
    @event = create(:old_event)
    @attendee = create(:attendee, event_id: @event.id)
    create(:booking, event_id: @attendee.event.id, user_id: @attendee.user.id)
  end

  before(:each) do
    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(
        @attendee.user
      )
  end

  scenario "attendees of an event can add reviews and ratings" do
    sleep 10
    visit "/events/#{@attendee.event.id}"

    fill_in "review[body]", with: "This was a great event"
    within(:css, ".rating-field") do
      page.find("#star3", visible: false).trigger("click")
    end

    within(:css, ".submit-review-button") do
      click_button("Add Review")
    end

    wait_for_ajax

    expect(page).to have_content("This was a great event")
    expect(page).to have_content("Your review has been saved")
  end
end
