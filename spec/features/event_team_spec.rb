require "rails_helper"

RSpec.feature "Event Team Management", type: :feature, js: true do
  before do
    @event = build(:regular_event)
    sign_up_and_create_an_event_manager
    visit root_path
    click_on "Create Event"
    fill_in "event[title]", with: @event.title
    fill_in "event[location]", with: @event.location
    fill_in "event[venue]", with: @event.venue
    find("#event_category_id").find(:xpath, "option[2]").select_option
    fill_in "event_description", with: @event.description
    click_on "Next"
    fill_in "event[ticket_types_attributes][0][name]", with: "free"
    fill_in "event[ticket_types_attributes][0][quantity]", with: 10
    fill_in "event[ticket_types_attributes][0][price]", with: 0.0
    email = "johndummy@example.com"
    fill_in "Enter staff email", with: email
    click_button "add_staff"
    click_link "Preview"
    click_button "Save"
  end

  scenario "Event Manager becomes a collaborator on creating event" do
    visit dashboard_path
    click_on "My Events Teams"
    click_on "Team Members"

    expect(page).to have_text "Collaborator"
  end

  scenario "Collaborators are allowed access to all event actions" do
    visit dashboard_path
    click_on "My Events Teams"

    expect(page).to have_content("Edit Event")
    expect(page).to have_content("Team Members")
    expect(page).to have_content("Tasks")
    expect(page).to have_content("Sponsors")
  end

  scenario "User not added to an event team cannot access event actions" do
    new_event = create(:regular_event, title: "New Event")
    visit dashboard_path
    click_on "My Events Teams"

    expect(page).not_to have_content new_event.title
  end
end
