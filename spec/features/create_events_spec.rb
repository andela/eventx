require 'rails_helper'
require 'database_cleaner'

RSpec.feature "CreateEvents", type: :feature do
Capybara.default_driver = :selenium
# Capybara.current_driver = :webkit


    before do
      # page.driver.browser.manage.window.resize_to(990,640)
      OmniAuth.config.test_mode = true
      Category.create({name: 'Alex', description: "Alex's special category for crappy things"})
      Category.create({name: 'Music', description: "music's special category for crappy things"})
    end

    after do
      DatabaseCleaner.clean
    end

    scenario "User can create events" do
      visit root_path

      click_link 'Log In'

      click_link 'Google'


      click_link 'Create Event'

      expect(page).to have_selector("p.center", text: "Create it, Preview it, Publish it!")
      expect(page).to have_field("event[title]", type: "text")
      expect(page).to have_field("event[venue]", type: "text")
      expect(page).to have_field("event[location]", type: "text")
      # expect(page).to have_field("event[map_url]", type: "hidden")

      fill_in "event[title]", with: "This is a test Event"
      fill_in "event[location]", with: "Lagos, Nigeria"

      #find(:xpath, "//input[@id='event_map_url']").set "https://maps.google.com/maps/place?q=Lagos,+Nigeria&ftid=0x103b8b2ae68280c1:0xdc9e87a367c3d9cb"
      fill_in "event[venue]", with: "Amity"

      # require "pry"; binding.pry;
      # select "Music", from: "event[category_id]"
      find('#event_category_id').find(:xpath, 'option[2]').select_option

      page.execute_script("$('#event_start_date').pickadate('picker').set('select', #{Date.tomorrow.to_time.to_i*1000})")
      page.execute_script("$('#event_end_date').pickadate('picker').set('select', #{Date.tomorrow.to_time.to_i*1000})")
      # fill_in "event[start_date]", with: "#{Date.tomorrow.strftime('%e %B, %Y ')}"

      # fill_in "event[end_date]", with: "#{Date.tomorrow.strftime('%e %B, %Y ')}"
      description = "This is a demo description for our event"
      fill_in "event[description]", with: description



      # expect(page).to have_selector("input[value='This is a test Event']")
      # expect(page).to have_selector("input[value='#{Date.tomorrow.to_s} 00:00:00 UTC +00:00']")
      # expect(page).to have_selector("input[value='Lagos, Nigeria']")


      click_link "Next"

      click_link "Preview"

      expect(page).to have_selector('h3.our-event-title', text: "This is a test Event")
      expect(page).to have_selector('p.our_event_description', text: description)
      expect(page).to have_selector('label.our-event-date', text: "#{Date.tomorrow.strftime("%-d %B, %Y")} to #{Date.tomorrow.strftime("%-d %B, %Y")}")

      click_button "Save"


      expect(page).to have_selector('h3.our-event-title', text: "This is a test Event")
      expect(page).to have_selector('p.our_event_description', text: description)
      expect(page).to have_selector('label.our-event-date', text: "#{Date.tomorrow.strftime("%b %d %Y")} to #{Date.tomorrow.strftime("%b %d %Y")}")


      # expect(page).to have_selector("li", text: "Venue")
      # expect(page).to have_selector("li", text: "About")



    end

end
