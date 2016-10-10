require "rails_helper"

RSpec.feature "Event Manager abilities", type: :feature, js: true do
  before(:each) do
    sign_up
  end

  scenario "user wants to become an Event Manager" do
    expect(page).to have_content "BECOME AN EVENT MANAGER"
    expect(page).not_to have_content "Create Event"
    expect(page).not_to have_content "Sign up"

    click_link "Become An Event Manager"
    expect(page.current_path).to eq "/manager_profiles/new"

    # with incorrect values
    fill_in "manager_profile[company_name]", with: ""
    fill_in "manager_profile[company_mail]", with: ""
    fill_in "manager_profile[company_phone]", with: ""
    fill_in "manager_profile[subdomain]", with: ""
    click_button "Submit"
    expect(page).to have_content form_submission_error

    # with correct values
    fill_in "manager_profile[company_name]", with: "Our Comapany"
    fill_in "manager_profile[company_mail]", with: "baba@yaho.com"
    fill_in "manager_profile[company_phone]", with: "08023439399"
    fill_in "manager_profile[subdomain]", with: "ladyb"
    click_button "Submit"
    expect(page.current_path).not_to eq "/manager_profiles/new"

    visit root_path
    expect(page).to have_content "CREATE EVENT"
    expect(page).not_to have_content "Become An Event Manager"
    click_link "Create Event"
    expect(page.current_path).to eq "/events/new"

    expect(page).to have_selector("p.center",
                                  text: "Create it, Preview it, Publish it!")
    expect(page).to have_field("event[title]", type: "text")
    expect(page).to have_field("event[venue]", type: "text")
    expect(page).to have_field("event[location]", type: "text")

    fill_in "event[title]", with: "This is a test Event"
    fill_in "event[location]", with: "Lagos, Nigeria"
    fill_in "event[venue]", with: "Amity"
    find("#event_category_id").find(:xpath, "option[2]").select_option

    date = Date.tomorrow.in_time_zone.to_i * 1000
    page.execute_script("$('#event_start_date')\
                        .pickadate('picker').set('select', #{date})")
    fill_in "event[start_time]", with: "09:00AM"

    page.execute_script("$('#event_end_date')\
                        .pickadate('picker').set('select', #{date})")
    fill_in "event[end_time]", with: "02:00PM"

    description = "This is a demo description for our event"
    fill_in "event[description]", with: description

    click_link "Next"
    fill_in "event[ticket_types_attributes][0][name]", with: "free"
    fill_in "event[ticket_types_attributes][0][quantity]", with: 10
    fill_in "event[ticket_types_attributes][0][price]", with: 0.0
    click_link "Preview"
    expect(page).to have_selector("h3.our-event-title",
                                  text: "This is a test Event")
    expect(page).to have_selector("p.our_event_description", text: description)
    date = Date.tomorrow.strftime("%-d %B, %Y")
    expect(page).to have_selector("label.our-event-date",
                                  text: "#{date}, 09:00AM - #{date}, 02:00PM")

    click_button "Save"

    expect(page).to have_selector("h3.our-event-title",
                                  text: "This is a test Event")
    expect(page).to have_selector("p.our_event_description", text: description)
    date1 = Date.tomorrow.strftime("%b %d %Y")
    expect(page).to have_selector("label.our-event-date",
                                  text: "#{date1}, 09:00AM - #{date1}, 02:00PM")
  end
end
