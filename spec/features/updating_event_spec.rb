require "rails_helper"

def visit_page_and_create_manage_profile
  visit root_path
  click_link "Sign up"
  click_link "Google"

  click_link "Become An Event Manager"
  fill_in "manager_profile[company_name]", with: "Our Comapany"
  fill_in "manager_profile[company_mail]", with: "baba@yaho.com"
  fill_in "manager_profile[company_phone]", with: "08023439399"
  fill_in "manager_profile[subdomain]", with: "ladyb"
  click_button "Submit"
end

RSpec.feature "Event Manager edits event", type: :feature, js: true do
  before(:each) do
    set_valid_omniauth
    OmniAuth.config.test_mode = true
    # FactoryGirl.create(:event)
  end

  after(:each) do
    DatabaseCleaner.clean
  end

  scenario "Manager logs in and tries to edit event" do
    visit_page_and_create_manage_profile
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
    find("a[data-activates = 'dropdown-user_option']").click
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
    expect(page).to have_content "Your Event was successfully updated"
    expect(page.current_path).to eq "/events/1"
    find("a[data-activates = 'dropdown-user_option']").click
    click_link "My Account"
    fill_in "Search By Event Name", with: "This is an edited Event"
    click_button "Search"
    expect(page).to have_content "This is an edited Event"
  end

  scenario "Manager fills in wrong event information" do
    visit_page_and_create_manage_profile
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
    description = "description " * 1000
    fill_in "event[description]", with: description

    click_link "Next"
    click_link "Preview"
    click_button "Save"

    expect(page).to have_content "Description is "\
    "too long (maximum is 1000 characters)"
    description = "short " * 2
    fill_in "event[description]", with: description
    click_link "Next"
    click_link "Preview"
    click_button "Save"

    expect(page).to have_content "Description is too "\
    "short (minimum is 20 characters)"
    description = "This is a demo description for our event"
    fill_in "event[description]", with: description
    invalid_date = Date.yesterday.in_time_zone.to_i * 1000
    page.execute_script("$('#event_end_date')\
                        .pickadate('picker').set('select', #{invalid_date})")
    click_link "Next"
    click_link "Preview"
    click_button "Save"

    expect(page).to have_content "End date can't be in the past"
    page.execute_script("$('#event_start_date')\
                        .pickadate('picker').set('select', #{date})")
    click_link "Next"
    click_link "Preview"
    click_button "Save"

    expect(page).to have_content "End date can't be in the past"
    click_link "Next"
    click_link "Preview"
    click_button "Save"

    expect(page).to have_content "This is a test Event"
    expect(page).to have_content "This is a demo description for our event"
  end
end
