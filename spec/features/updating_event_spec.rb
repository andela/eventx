require "rails_helper"

RSpec.feature "Event Manager edits event", type: :feature, js: true do
  scenario "Manager logs in and tries to edit event" do
    sign_up_and_create_an_event_manager
    visit root_path
    click_link "Create Event"
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
    email = "johndummy@example.com"
    fill_in "Enter staff email", with: email
    click_button "add_staff"
    click_link "Preview"
    click_button "Save"

    find("a[data-activates = 'dropdown-user_option']", match: :first).
      trigger("click")
    find_link("My Account").trigger("click")
    expect(page).to have_content "This is a test Event"
    expect(page).to have_content "Lagos, Nigeria"
    find("a[data-activates = 'dropdown-1']").hover
    within ".dropdown-content" do
      find_link("Edit Event").trigger("click")
    end
    fill_in "event[title]", with: "This is an edited Event"
    fill_in "event[location]", with: "Obodo, Oyibo"
    fill_in "event[venue]", with: "LAmity"
    click_link "Next"

    click_link "Preview"
    sleep 2
    click_button "Save"
    sleep 2

    expect(page).to have_content "This is an edited Event"
    expect(page).to have_content update_successful_message("event")
    expect(page.current_path).to eq "/events/1"

    find("a[data-activates = 'dropdown-user_option']", match: :first).
      trigger("click")
    find_link("My Account").trigger("click")
    fill_in "Search By Event Name", with: "This is an edited Event"
    expect(page).to have_content "This is an edited Event"
  end

  scenario "Manager fills in a long description" do
    sign_up_and_create_an_event_manager
    visit root_path
    click_link "Create Event"
    sleep 3
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

    description = "description " * 84
    sleep 3
    fill_in "event[description]", with: description
    click_link "Next"
    fill_in "event[ticket_types_attributes][0][name]", with: "free"
    fill_in "event[ticket_types_attributes][0][quantity]", with: 10
    fill_in "event[ticket_types_attributes][0][price]", with: 0.0
    email = "johndummy@example.com"
    fill_in "Enter staff email", with: email
    click_button "add_staff"
    click_link "Preview"
    sleep 2
    click_button "Save"
    sleep 2
    expect(page).to have_content "Description is \
      too long (maximum is 1000 characters)"
  end

  scenario "Manager fills in a short description" do
    sign_up_and_create_an_event_manager
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
    description = "short "
    fill_in "event[description]", with: description
    click_link "Next"
    fill_in "event[ticket_types_attributes][0][name]", with: "free"
    fill_in "event[ticket_types_attributes][0][quantity]", with: 10
    fill_in "event[ticket_types_attributes][0][price]", with: 0.0
    email = "johndummy@example.com"
    fill_in "Enter staff email", with: email
    click_button "add_staff"
    click_link "Preview"
    click_button "Save"
    expect(page).to have_content "Description is too \
      short (minimum is 20 characters)"
  end

  scenario "Manager does not create ticket" do
    sign_up_and_create_an_event_manager
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
    expect(page).to have_content("Ticket types can't be blank")
  end
end
