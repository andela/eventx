require "rails_helper"

RSpec.feature "Event Manager edits event", type: :feature, js: true do

  before(:each) do
    manager = create(:regular_manager_profile)
    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(manager.user)
  end

 scenario "Manager logs in and tries to edit event" do
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

    page.find("#btn_booking").trigger("click")

    fill_in "event[ticket_types_attributes][0][name]", with: "free"
    fill_in "event[ticket_types_attributes][0][quantity]", with: 10
    fill_in "event[ticket_types_attributes][0][price]", with: 0.0
    email = "johndummy@example.com"
    fill_in "Enter staff email", with: email
    click_button "add_staff"

    page.find("#btn_booking").trigger("click")
    page.find("#btn_booking").trigger("click")
    page.find("#saved_events").trigger("click")

    # page.first("li#display-account", visible: false).find("a.our-dropdown-content").trigger("click")
    # find(:xpath, '//*[@id="display-account"]/a', visible: false).trigger("click")
    visit "/users/1"

    # page.find("#bestill", visible:false).trigger("click")
    # find("a[data-activates = 'dropdown-user_option']").click

    # click_link "My Account"
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
    find("#search-button").click
    expect(page).to have_content "This is an edited Event"
  end

  scenario "Manager fills in a long description" do
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
    description = "description " * 84
    fill_in "event[description]", with: description
     page.find("#btn_booking").trigger("click")
    fill_in "event[ticket_types_attributes][0][name]", with: "free"
    fill_in "event[ticket_types_attributes][0][quantity]", with: 10
    fill_in "event[ticket_types_attributes][0][price]", with: 0.0
    email = "johndummy@example.com"
    fill_in "Enter staff email", with: email
    click_button "add_staff"
    expect(page).to have_selector("#toast-container", "staff has been successfully added")
    page.find("#btn_booking").trigger("click")
    expect(page).to have_content("Select a Template")
    page.find("#btn_booking").trigger("click")
    expect(page).to have_content("Preview Event")
    page.find("#saved_events").trigger("click")
    expect(page).to have_selector("#toast-container", "Description is "\
    "too long (maximum is 1000 characters)")
  end

  scenario "Manager fills in a short description" do
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
    description = "short"
    fill_in "event[description]", with: description
    page.find("#btn_booking").trigger("click")
    fill_in "event[ticket_types_attributes][0][name]", with: "free"
    fill_in "event[ticket_types_attributes][0][quantity]", with: 10
    fill_in "event[ticket_types_attributes][0][price]", with: 0.0
    user = User.last
    fill_in "Enter staff email", with: user.email
    click_button "add_staff"
    expect(page).to have_selector("#toast-container", "staff has been successfully added")
    page.find("#btn_booking").trigger("click")
    expect(page).to have_content("Select a Template")
    page.find("#btn_booking").trigger("click")
    expect(page).to have_content("Preview Event")
    page.find("#saved_events").trigger("click")
    expect(page).to have_selector("#toast-container", "Description is too short (minimum is 20 characters)")
  end

  scenario "Manager does not create ticket" do
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
    page.find("#btn_booking").trigger("click")
    expect(page).to have_content("Add Ticket")
    page.find("#btn_booking").trigger("click")
    expect(page).to have_content("Select a Template")
    page.find("#btn_booking").trigger("click")
    expect(page).to have_content("Preview Event")
    page.find("#saved_events").trigger("click")
    expect(page).to have_selector("#ticket-display", "Ticket types can't be blank")
  end
end
