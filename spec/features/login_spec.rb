require "rails_helper"

RSpec.feature "Login:", type: :feature, js: true do
  before do
    OmniAuth.config.test_mode = true
  end

  scenario "User visits the homepage" do
    visit(root_path)
    expect(page).to have_selector("h2.header", text: "Your Passions to Life")
    expect(page).to have_selector("h5.header", text: "Create a Memorable Event")
    expect(page).to have_selector("a", text: "START AN EVENT")

    click_link "Log In"

    expect(page).to have_selector("h5", text: "Sign in with:")
    expect(page).to have_selector("div.sso_option", count: 6)
  end

  scenario "User tries to login with google" do
    visit new_event_path
    expect(page).to have_content "START AN EVENT"

    click_link "Start an Event"
    click_link "Google"
    visit root_path
    expect(page).to have_content "BECOME AN EVENT MANAGER"
    expect(page).to have_button "Search"
  end

  scenario "User tries to create event" do
    sign_up
    visit "/events/new"
    expect(page).to have_content not_authorized
  end

  scenario "User tries to edit event" do
    sign_up
    event = create(:event)
    visit "/events/#{event.id}/edit"
    expect(page).to have_content not_authorized
  end

  scenario "User tries to visit bad address" do
    visit "/postoffice"
    expect(page).to have_content "Create a Memorable Event"
  end
end
