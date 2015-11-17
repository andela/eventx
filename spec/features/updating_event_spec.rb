require "rails_helper"
require "database_cleaner"

RSpec.feature "Event Manager edits event", type: :feature, js: true do
  before do
    set_valid_omniauth
    OmniAuth.config.test_mode = true
    google_oauth2 = OmniAuth.config.mock_auth[:google_oauth2]
    Rails.application.env_config["omniauth.auth"] = google_oauth2
    FactoryGirl.create(:category)
    FactoryGirl.create(:category2)
  end
  after do
    DatabaseCleaner.clean
  end
  scenario "Manager logs in and tries to edit event" do
    visit root_path
    click_link "Log In"
    within ".modal-content" do
      click_link "Google"
    end
    click_link "Become An Event Manager"
    fill_in "manager_profile[company_name]", with: "Our Comapany"
    fill_in "manager_profile[company_mail]", with: "baba@yaho.com"
    fill_in "manager_profile[company_phone]", with: "08023439399"
    fill_in "manager_profile[subdomain]", with: "ladyb"
    click_button "Submit"
    visit root_path
    click_link "Create Event"
    fill_in "event[title]", with: "This is a test Event"
    fill_in "event[location]", with: "Lagos, Nigeria"
    fill_in "event[venue]", with: "Amity"
    find("#event_category_id").find(:xpath, "option[2]").select_option

    date = Date.tomorrow.in_time_zone.to_i * 1000
    page.execute_script("$('#event_start_date')\
                        .pickadate('picker').set('select', #{date})")
    page.execute_script("$('#event_end_date')\
                        .pickadate('picker').set('select', #{date})")

    description = "This is a demo description for our event"
    fill_in "event[description]", with: description

    click_link "Next"
    click_link "Preview"
    click_button "Save"
    click_link "John"
    click_link "My Account"
    expect(page).to have_content "This is a test Event"
    expect(page).to have_content "Lagos, Nigeria"
    find("a[data-activates = 'dropdown-1']").click
    within ".dropdown-content" do
      click_link "Edit Event"
    end
    fill_in "event[title]", with: "This is an edited Event"
    fill_in "event[location]", with: "Obodo, Oyibo"
    fill_in "event[venue]", with: "LAmity"
    click_link "Next"
    click_link "Preview"
    click_button "Save"
    expect(page).to have_content "This is an edited Event"
    expect(page).to have_content "Obodo, Oyibo"
    expect(page).to have_content "Your Event was successfully updated"
    fill_in "search", with: "This is a test Event"
    expect(page).to have_content "No Event found"
    expect(page).not_to have_content "This is a test Event"
    fill_in "search", with: "This is an edited Event"
    expect(page).to have_content "Obodo, Oyibo"
    expect(page).to have_content "This is an edited Event"
  end
end
