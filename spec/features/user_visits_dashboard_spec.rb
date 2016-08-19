require "rails_helper"

RSpec.feature "User visits dashboard", type: :feature, js: true do
  scenario "when not logged in as an event manager" do
    sign_up

    visit dashboard_path

    expect(page).not_to have_css "h5", text: "Account Overview"
    expect(page).to have_css "h5", text: "My Events"
  end

  scenario "when logged in as an event manager" do
    sign_up_and_create_an_event_manager

    visit dashboard_path

    expect(page).to have_css "h5", text: "Account Overview"
    expect(page).to have_css "h5", text: "My Events"
  end
end

