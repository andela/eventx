require "rails_helper"

RSpec.feature "Login:", type: :feature do
  before do
    OmniAuth.config.test_mode = true
  end
  after do
    DatabaseCleaner.clean
  end
  scenario "User visits the homepage" do
    visit(root_path)
    expect(page).to have_selector("h1.header", text: "EventX")
    expect(page).to have_selector("h5.header", text: "Simple, Easy, Build it")
    expect(page).to have_selector("h1.header", text: "EventX")
    expect(page).to have_selector("a", text: "Sign up")

    click_link "Log In"

    expect(page).to have_selector("h5", text: "Sign in with:")
    expect(page).to have_selector("div.sso_option", count: 6)
  end

  scenario "User tries to login with google" do
    visit new_event_path
    expect(page).to have_content "Sign up"

    click_link "Sign up"
    click_link "Google"
    expect(page).to have_content "Become An Event Manager"
    expect(page).to have_button "Search"
    expect(page).to have_content "UPCOMING"
    expect(page).to have_content "FEATURED"
  end

  scenario "User tries to create event" do
    visit root_path
    click_link "Sign up"
    click_link "Google"
    visit "/events/new"
    expect(page).to have_content "Become An Event Manager"
  end
  scenario "User tries to edit event" do
    visit root_path
    click_link "Sign up"
    click_link "Google"
    visit "/events/1/edit"
    expect(page).to have_content "Become An Event Manager"
  end
  scenario "User tries to view event" do
    visit "/events"
    expect(page).to have_content "Location"
  end
  scenario "User tries to visit bad address" do
    visit "/postoffice"
    expect(page).to have_content "Simple, Easy, Build it"
  end

  # scenario "User tries to visit a bad subdomain" do
  #   visit root_path
  #   save_and_open_page
  #   expect(page).to have_content "CONTINUE TO THE EVENT-X WEBSITE."
  # end
end
