require "rails_helper"

RSpec.feature "Login:", type: :feature do
  before do
    OmniAuth.config.test_mode = true
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
    visit root_path
    click_link "Sign up"
    click_link "Google"
    expect(page).to have_content "Become An Event Manager"
    expect(page).to have_button("Search")
    expect(page).to have_content "LATEST"
    expect(page).to have_content "FEATURED"
  end
end
